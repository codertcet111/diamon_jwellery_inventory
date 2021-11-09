class SaleItem < ApplicationRecord

  belongs_to :sale, inverse_of: :sale_items
  belongs_to :stock, inverse_of: :sale_item, optional: true
  belongs_to :stock_pc_range
  belongs_to :stock_sub_type, optional: true
  before_create :copy_stock_property, :stock_entire_re_calculation
  after_commit :mark_stock_sold, :update_stock_pc_range_carats, on: :create
  before_update :update_stock_pc_range_carats_if_carats_updated
  after_commit :recalculate_sales_final_amount, on: :update

  enum shape: DIAMOND_SHAPES
  enum color: DIAMOND_COLORS
  enum clarity: DIAMOND_CLARITY

  def update_stock_pc_range_carats
    pc_range = self.stock_pc_range.reload
    pc_range.sale_stocks += self.carat
    pc_range.balance_stocks -= self.carat
    pc_range.save
  end

  def update_stock_pc_range_carats_if_carats_updated
    if carat_changed?
      pc_range = self.stock_pc_range.reload
      # first reduce the existing stocks value from pc range 
      pc_range.sale_stocks -= carat_was.to_f
      pc_range.balance_stocks += carat_was.to_f
      pc_range.save
      pc_range.reload
      # now add the updated stocks value
      pc_range.sale_stocks += self.carat.to_f
      pc_range.balance_stocks -= self.carat.to_f
      pc_range.save
    end
  end


  rails_admin do
    navigation_label Proc.new { "I: Inventory Managment" }  
    edit do
      fields do
        help " <br>".html_safe
      end
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
      field :stock_pc_range do
        label 'Stock Range'
        required true
      end
      field :stock_sub_type do
        label 'Stock Sub Type'
        required true
      end
      field :stock do
        required false
        associated_collection_scope do
          sale_item = bindings[:object]
          proc { |scope| Stock.where.not(state: 5) }
        end
      end
      field :amount do
        required true
      end
      field :rate_per_carat do
        label 'Rate per Carat (Rs.)'
        required true
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
      field :sale do
        required true
      end
      include_all_fields
      exclude_fields :shape
      exclude_fields :color
      exclude_fields :clarity
    end
  end

  def name
    stock.present? ? "Sale Item against Stock: #{stock.stock_key}" : "Sale Item #{name_based_on_subtype}"
  end

  def name_based_on_subtype
    if true || self.stock_sub_type.name.downcase.include?('diamond')
      "carat: #{self.carat} Cr"
    else
      "weight: #{self.weight} Grm"
    end
  end

  # Do thise before Create / after each update to discount_percentage, additional_disc_1, additional_disc_2, additional_disc_3, rate_per_carat, loose_selection_carat, amount, carat
  def stock_entire_re_calculation
    if true || self.stock_sub_type.name.downcase.include?('diamond')
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
    stock.sold_out! if self.stock
  end

  def copy_stock_property
    if self.stock
      self.shape = self.stock.shape
      self.color = self.stock.color
      self.clarity = self.stock.clarity
    end
  end

end