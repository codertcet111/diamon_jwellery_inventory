namespace :ledger_groups do
  desc "create ledger groups one time task"
  task create_groups: :environment do
    LEDGER_GROUPS.values.each do |group_name|
      LedgerGroup.find_or_create_by(name: group_name)
    end
  end
end
