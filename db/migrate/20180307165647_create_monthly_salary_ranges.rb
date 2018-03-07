class CreateMonthlySalaryRanges < ActiveRecord::Migration
  def change
    create_table :monthly_salary_ranges do |t|
      t.string :range

      t.timestamps null: false
    end
  end
end
