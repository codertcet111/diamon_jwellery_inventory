class StockSubType < ApplicationRecord
  belongs_to :stock_type

  class << self
    
    def loose_diamond_id
      where("name like %loose%").first.id rescue nil
    end

    def cut_and_polish_diamond_id
      where("name like %polish%").first.id rescue nil
    end

    def jewellary_ids
      where("name like %jewellary%").pluck(:id)
    end

  end
end
