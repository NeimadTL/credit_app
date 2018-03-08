class AddBalanceToBankAccounts < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :balance, :decimal, :default => 0
  end
end
