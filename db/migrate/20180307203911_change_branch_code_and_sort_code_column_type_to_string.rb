class ChangeBranchCodeAndSortCodeColumnTypeToString < ActiveRecord::Migration
  def change
    change_column :bank_accounts, :branch_code, :string
    change_column :bank_accounts, :sort_code, :string
  end
end
