class TermsTypeInSalesAndPurchases < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :terms_type, :integer
  	add_column :purchases, :terms_type, :integer
  end
end
