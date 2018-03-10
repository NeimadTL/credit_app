require 'rails_helper'

RSpec.describe MonthlySalaryRange, type: :model do

  it { should validate_presence_of :range_tid }
  it { should validate_numericality_of(:range_tid) }
  it { should validate_presence_of :range }

end
