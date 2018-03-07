class MonthlySalaryRange < ActiveRecord::Base

  validates :range, presence: true

  
end
