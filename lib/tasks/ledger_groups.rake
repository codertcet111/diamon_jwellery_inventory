namespace :ledger_groups do
  desc "create ledger groups one time task"
  task create_groups: :environment do
    LEDGER_GROUPS.values.each do |group_name|
      LedgerGroup.find_or_create_by(name: group_name)
    end
  end
end

'''
LedgerGroup : assets OR liability

Duties and Taxes : liability
Direct Expenses OR Expenses(Direct) : Covered in Trading account
Indirect Expenses OR Expense(Indirect) : Covered in Profit and Loss account
Indirect Income OR Income(Indirect) : Covered in Profit and Loss account
Bank Account : assets
Deposit Account : assets
Capital A/c : shareholders fund (In balance sheet)
Current Assets : assets
Current Liabilities : liability
Loans and Advances : assets
Loans Liabilities : liability
Fixed Assets : assets
Bank OCC : liability
Bank OD : liability
Cash in Hand  : assets
Investments : assets
Stock-in-hand : assets
Misc. Expense : Covered in Profit and Loss account
Suspense A/c : Covered in Trading account
Secured Loan : liability
Unsecured Loan : liability
Reserve & Surplus : shareholders fund (In balance sheet)



'''
