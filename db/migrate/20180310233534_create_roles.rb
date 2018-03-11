class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :role_tid
      t.string :role_label

      t.timestamps null: false
    end
  end
end
