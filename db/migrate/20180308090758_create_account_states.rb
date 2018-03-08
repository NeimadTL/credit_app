class CreateAccountStates < ActiveRecord::Migration
  def change
    create_table :account_states do |t|
      t.string :state

      t.timestamps null: false
    end
  end
end
