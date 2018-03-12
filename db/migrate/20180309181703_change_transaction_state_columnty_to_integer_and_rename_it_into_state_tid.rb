class ChangeTransactionStateColumntyToIntegerAndRenameItIntoStateTid < ActiveRecord::Migration
  def change
    change_column :transactions, :transaction_state, 'integer USING CAST(transaction_state AS integer)'
    rename_column :transactions, :transaction_state, :state_tid
  end
end
