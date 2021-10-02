class Stock < ApplicationRecord
  belongs_to :purchase, optional: true, inverse_of: :stocks
  belongs_to :stock_sub_type
  has_many :expenses
  has_many :stock_histories
  has_one :sale_item, inverse_of: :stock
  enum shape: DIAMOND_SHAPES
  enum color: DIAMOND_COLORS
  enum clarity: DIAMOND_CLARITY
  enum color_shades: DIAMOND_COLOR_SHADES
  enum fancy_color: DIAMOND_FANCY_COLOR
  enum color_intensity: DIAMOND_COLOR_INTENSITY
  enum color_overtone: DIAMOND_COLOR_OVERTONE
  enum flouresence: DIAMOND_FLOURESENCE
  enum lab: DIAMOND_LAB
  enum cut: DIAMOND_CUT
  enum polish: DIAMOND_POLISH
  enum symmetry: DIAMOND_SYMMETRY
  enum black_table_inclusion: DIAMOND_BLACK_TABLE_INCLUSION
  enum black_crown_inclusion: DIAMOND_BLACK_CROWN_INCLUSION
  enum white_table_inclusion: DIAMOND_WHITE_TABLE_INCLUSION
  enum white_crown_inclusion: DIAMOND_WHITE_CROWN_INCLUSION
  enum milky_inclusion: DIAMOND_MILKY_INCLUSION
  enum open_table_inclusion: DIAMOND_OPEN_TABLE_INCLUSION
  enum open_crown_inclusion: DIAMOND_OPEN_CROWN_INCLUSION
  enum open_pavilion_inclusion: DIAMOND_OPEN_PAVILION_INCLUSION
  enum eye_clean_inclusion: DIAMOND_EYE_CLEAN_INCLUSION
  enum rough_origin: DIAMOND_ROUGH_ORIGIN
  enum heart_and_arrow: DIAMOND_HEAR_AND_ARROW

  after_create :assign_stock_key

  enum state: { available: 0, in_lab: 1, in_factory: 2, out_of_memo: 3, business_process: 4, sold_out: 5 }
  # when state is changed from in factory to any then need to add weight loss

  before_save :create_stock_history

  accepts_nested_attributes_for :expenses

  scope :in_stock_all, -> { where("state not in (?)",Stock.states[:sold_out]) }
  scope :in_stock_loose_diamond, -> { in_stock_all.where(stock_sub_type_id: StockSubType.loose_diamond_id)}
  scope :in_stock_cut_polish_diamond, -> { in_stock_all.where(stock_sub_type_id: StockSubType.cut_and_polish_diamond_id)}
  scope :in_stock_jewellary, -> { in_stock_all.where("stock_sub_type_id IN (?)", StockSubType.jewellary_ids)}


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