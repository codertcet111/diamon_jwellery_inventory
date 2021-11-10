class StockPcRange < ApplicationRecord
  has_many :stocks
  has_many :sale_items
  scope :in_stock_all, -> { where("balance_stocks > ?",0.0) }
  scope :out_of_stock, -> { where("balance_stocks <= ?",0.0) }
  # scope :in_stock_diamonds, -> { in_stock_all.where(stock_sub_type_id: StockSubType.loose_diamond_id)}

  rails_admin do
    navigation_label Proc.new { "S: Stock" }
    list do
      include_all_fields
      field :purchase_stocks do
        label 'Purchase Stocks (Cr)'
      end
      field :sale_stocks do
        label 'Sale Stocks (Cr)'
      end
      field :balance_stocks do
        label 'Balance Stocks (Cr)'
      end
    end
    edit do
      include_all_fields
      fields do
        help " <br>".html_safe
      end
      exclude_fields :stocks
      exclude_fields :sale_items 
    end
    field :name do
      label 'Range'
      required true
    end
    field :min_value do
      label 'Minimum value (Rs)'
      required false
    end
    field :max_value do
      label 'Maximum value (Rs)'
      required false
    end
    exclude_fields :stocks
    exclude_fields :sale_items
  end

end
