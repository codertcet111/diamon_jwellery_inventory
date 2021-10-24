class SalesInReceiptMakeNullTrue < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :receipts, :sale_id, true
  end
end
