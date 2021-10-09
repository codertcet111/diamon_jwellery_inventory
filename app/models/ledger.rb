class Ledger < ApplicationRecord
  belongs_to :ledger_group
  has_many :to_contras, :class_name => "Contra", :foreign_key => "ledger_1_id"
  has_many :from_contras, :class_name => "Contra", :foreign_key => "ledger_2_id"

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
