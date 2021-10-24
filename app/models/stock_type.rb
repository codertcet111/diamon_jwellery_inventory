class StockType < ApplicationRecord
	rails_admin do
		navigation_label Proc.new { "S: Stock" }
	end
end
