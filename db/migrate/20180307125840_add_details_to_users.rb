class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :birthday, :date
    add_column :users, :city, :string
    add_column :users, :monthly_salary_range, :string
    add_column :users, :country, :string
  end
end
