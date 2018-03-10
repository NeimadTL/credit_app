class AddRangeTidToMonthlySalaryRange < ActiveRecord::Migration
  def change
    add_column :monthly_salary_ranges, :range_tid, :integer
  end
end
