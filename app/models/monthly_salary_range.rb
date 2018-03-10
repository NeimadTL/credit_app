class MonthlySalaryRange < ActiveRecord::Base


  self.primary_key = 'range_tid'

  validates :range_tid, presence: true, numericality: { only_integer: true }
  validates :range, presence: true


end
