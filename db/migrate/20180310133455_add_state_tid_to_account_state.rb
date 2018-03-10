class AddStateTidToAccountState < ActiveRecord::Migration
  def change
    add_column :account_states, :state_tid, :integer
  end
end
