class CreateTransactionStates < ActiveRecord::Migration
  def change
    create_table :transaction_states do |t|
      t.integer :state_tid
      t.string :state

      t.timestamps null: false
    end
  end
end
