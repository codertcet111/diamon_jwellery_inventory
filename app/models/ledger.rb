class Ledger < ApplicationRecord
  belongs_to :ledger_group

  rails_admin do
    navigation_label Proc.new { "Ledger" }
    show do
    	exclude_fields :address
    	field :ledger_address
    end
    list do
    	exclude_fields :address
    	field :ledger_address_short do
	        label 'Ledger Address'
	      end
    end
  end

  def ledger_address_short
  	self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def ledger_address
  	self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end
end
