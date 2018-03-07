class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.integer :branch_code
      t.integer :sort_code
      t.string :account_number
      t.integer :rib_key
      t.string :account_state
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
