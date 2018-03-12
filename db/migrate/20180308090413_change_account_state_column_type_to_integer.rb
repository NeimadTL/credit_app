class ChangeAccountStateColumnTypeToInteger < ActiveRecord::Migration
  def change
    change_column :bank_accounts, :account_state, 'integer USING CAST(account_state AS integer)'
    rename_column :bank_accounts, :account_state, :account_state_id
  end
end
