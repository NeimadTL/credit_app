class ChangeTransactionStateColumntyToIntegerAndRenameItIntoStateTid < ActiveRecord::Migration
  def change
    change_column :transactions, :transaction_state, :integer
    rename_column :transactions, :transaction_state, :state_tid
  end
end
