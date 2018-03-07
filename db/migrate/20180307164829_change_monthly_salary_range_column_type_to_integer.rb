class ChangeMonthlySalaryRangeColumnTypeToInteger < ActiveRecord::Migration
  def change
    change_column :users, :monthly_salary_range, :integer
    rename_column :users, :monthly_salary_range, :monthly_salary_range_id
  end
end
