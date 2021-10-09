class Tax < ApplicationRecord
	has_many :purchases
	has_many :sales_taxes
	has_many :sales, through: :sales_taxes

	rails_admin do
		navigation_label Proc.new { "Tax" }
	    edit do
	    	exclude_fields :purchases
	    	exclude_fields :sales_taxes
	    	exclude_fields :sales
	    end
	end
end
