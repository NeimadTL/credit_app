class MonthlySalaryRange < ActiveRecord::Base


  self.primary_key = 'range_tid'

  BETWEEN_0_AND_999_RANGE_TID = 1
  BETWEEN_1000_AND_1999_RANGE_TID = 2
  BETWEEN_2000_AND_2999_RANGE_TID = 3
  GREATER_THAN_3000_RANGE_TID = 4

  validates :range_tid, presence: true, numericality: { only_integer: true }
  validates :range, presence: true


end
