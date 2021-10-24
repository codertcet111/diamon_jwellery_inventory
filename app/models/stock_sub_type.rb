class StockSubType < ApplicationRecord
  belongs_to :stock_type

  class << self
    
    def loose_diamond_id
      where("LOWER(name) like '%loose%'").first.id rescue nil
    end

    def cut_and_polish_diamond_id
      where("LOWER(name) like '%polish%'").first.id rescue nil
    end

    def jewellary_ids
      where("LOWER(name) like '%jewellary%'").pluck(:id)
    end

  end

  rails_admin do
    navigation_label Proc.new { "S: Stock" }
  end
end
