class Tax < ApplicationRecord
	has_many :purchases_taxes
	has_many :purchases, through: :purchases_taxes
	has_many :sales_taxes
	has_many :sales, through: :sales_taxes
	has_many :ledger_expenses_taxes
	has_many :ledger_expenses, through: :ledger_expenses_taxes
	has_many :brokerages_taxes
	has_many :brokerages, through: :brokerages_taxes

	rails_admin do
		navigation_label Proc.new { "Tax" }
	    edit do
	    	exclude_fields :purchases
	    	exclude_fields :sales_taxes
	    	exclude_fields :purchases_taxes
	    	exclude_fields :sales
	    	exclude_fields :ledger_expenses_taxes
	    	exclude_fields :ledger_expenses
	    	exclude_fields :brokerages_taxes
	    	exclude_fields :brokerages
	    end
	end
end
