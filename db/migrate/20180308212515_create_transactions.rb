class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :transaction_state
      t.integer :bank_account_id

      t.timestamps null: false
    end
  end
end
