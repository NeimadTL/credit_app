require 'rails_helper'

RSpec.describe MonthlySalaryRange, type: :model do

  it { should validate_presence_of :range }

end
