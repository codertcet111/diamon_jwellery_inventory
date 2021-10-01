class Stock < ApplicationRecord
  belongs_to :purchase, optional: true, inverse_of: :stocks
  has_many :expenses
  has_many :stock_histories
  has_one :sale_item, inverse_of: :stock
  enum shape: DIAMOND_SHAPES
  enum color: DIAMOND_COLORS
  enum clarity: DIAMOND_CLARITY
  after_create :assign_stock_key

  enum state: { available: 0, in_lab: 1, in_factory: 2, out_of_memo: 3, business_process: 4, sold_out: 5 }
  # when state is changed from in factory to any then need to add weight loss

  before_save :create_stock_history

  accepts_nested_attributes_for :expenses

  def create_stock_history
    if self.persisted? && state_changed?
      stock_history = self.stock_histories.new
      stock_history.notes = "State changed from <b>#{self.state_was.titleize}</b> to <b>#{self.state.titleize}</b> on <b>#{Time.now.strftime('%d %b %Y %l:%M %p')}</b>"
      stock_history.save
    end
  end

  rails_admin do
    include_all_fields
    field :stock_key do
      label 'Stock ID'
    end
    edit do
      # field :shape do
      #   required true
      # end
      # field :color do
      #   required true
      # end
      # field :clarity do
      #   required true
      # end
      # field :carat do
      #   required true
      # end
      # field :weight do
      #   required true
      # end
      # field :rap do
      #   required true
      # end
      # field :amount do
      #   required true
      # end
      exclude_fields :stock_key
      exclude_fields :purchase
      exclude_fields :stock_histories
      exclude_fields :sale_item
      exclude_fields :expenses
    end
  end

  def name
    "Stock: " + self.stock_key.to_s
  end

  def assign_stock_key
    if purchase.stocks.count == 1
      self.update_column(:stock_key, purchase.id)
    else
      purchase.stocks.order(:id).each_with_index do |stock, index|
        alpha = ('A'..'Z').to_a[index]
        stock.update_column(:stock_key, "#{purchase.id}#{alpha}")
      end
    end
  end

end
