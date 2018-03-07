require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of :title }
  it { should validate_presence_of :firstname }
  it { should validate_presence_of :lastname }
  it { should validate_presence_of :birthday }
  it { should validate_presence_of :city }
  it { is_expected.to belong_to(:monthly_salary_range) }
end
