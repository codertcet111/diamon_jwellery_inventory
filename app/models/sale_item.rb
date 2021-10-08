class SaleItem < ApplicationRecord

  belongs_to :sale, inverse_of: :sale_items
  belongs_to :stock, inverse_of: :sale_item
  after_create :mark_stock_sold

  enum shape: DIAMOND_SHAPES
  enum color: DIAMOND_COLORS
  enum clarity: DIAMOND_CLARITY

  rails_admin do
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
      field :amount do
        required true
      end
      include_all_fields
      field :additional_disc_1 do
        label 'Additional Discount 1 (%)'
      end
      field :additional_disc_2 do
        label 'Additional Discount 2 (%)'
      end
      field :additional_disc_3 do
        label 'Additional Discount 3 (%)'
      end
      field :amount do
        label "Total Amount (Rs.) (* Final Amount)"
      end
      field :stock do
        required true
        associated_collection_scope do
          sale_item = bindings[:object]
          proc { |scope| Stock.where.not(state: 5) }
        end
      end
      field :sale do
        required true
      end
    end
  end

  def name
    "Sale Item against Stock: #{stock.stock_key}"
  end

private

  def mark_stock_sold
    stock.sold_out!
  end

end