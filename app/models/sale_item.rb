class SaleItem < ApplicationRecord

  belongs_to :sale, inverse_of: :sale_items
  belongs_to :stock, inverse_of: :sale_item
  before_create :copy_stock_property, :stock_entire_re_calculation
  after_create :mark_stock_sold
  after_update :recalculate_sales_final_amount

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
      field :rate_per_carat do
        label 'Rate per Carat (Rs.)'
      end
      field :discount_percentage do
        label 'Discount (%)'
      end
      field :additional_disc_1 do
        label 'Additional Discount 1 (%)'
      end
      field :additional_disc_2 do
        label 'Additional Discount 2 (%)'
      end
      field :additional_disc_3 do
        label 'Additional Discount 3 (%)'
      end
      field :carat do
        label 'Total Carat'
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
      exclude_fields :shape
      exclude_fields :color
      exclude_fields :clarity
    end
  end

  def name
    "Sale Item against Stock: #{stock.stock_key}"
  end

  # Do thise before Create / after each update to discount_percentage, additional_disc_1, additional_disc_2, additional_disc_3, rate_per_carat, loose_selection_carat, amount, carat
  def stock_entire_re_calculation
    if self.stock.stock_sub_type.name.downcase.include?('diamond')
      discounts = [discount_percentage, additional_disc_1, additional_disc_2, additional_disc_3]
      i_rate_per_carat = self.rate_per_carat
      # Now apply each discount on rate per carat
      discounts.each do |disc|
        i_rate_per_carat = i_rate_per_carat * (1 - (disc.to_f / 100)) if (disc && disc > 0)
      end
      self.amount = i_rate_per_carat.to_f * self.carat.to_f
    else
      # Pending calculation for jewellary
    end
  end

  def recalculate_sales_final_amount
    if saved_change_to_amount? || saved_change_to_discount_percentage? || saved_change_to_additional_disc_1? || saved_change_to_additional_disc_2? || saved_change_to_additional_disc_3? || saved_change_to_rate_per_carat? || saved_change_to_carat?
      self.stock_entire_re_calculation
      self.save
      self.sale.perform_calculations
    end
  end

private

  def mark_stock_sold
    stock.sold_out!
  end

  def copy_stock_property
    self.shape = self.stock.shape
    self.color = self.stock.color
    self.clarity = self.stock.clarity
  end

end