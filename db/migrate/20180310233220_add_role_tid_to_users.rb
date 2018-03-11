class AddRoleTidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_tid, :integer
  end
end
