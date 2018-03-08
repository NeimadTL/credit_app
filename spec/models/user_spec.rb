require 'rails_helper'

RSpec.describe User, type: :model do

  User.delete_all  
  range = MonthlySalaryRange.first

  let(:user) {
    User.create!(title: "Mr", firstname: "John", lastname: "Doe",
      city: "San Francisco", birthday: "22/12/1992", monthly_salary_range_id: range.id,
      email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")
  }

  it { should validate_presence_of :title }
  it { should validate_presence_of :firstname }
  it { should validate_presence_of :lastname }
  it { should validate_presence_of :birthday }
  it { should validate_presence_of :city }
  it { is_expected.to belong_to(:monthly_salary_range) }
  it { is_expected.to have_many(:bank_accounts) }

  it { is_expected.to callback(:setup_country).after(:create) }


  describe "when user is created, #setup_country should set country to 'FR'" do
    it { expect(user.country).to eql "FR" }
  end

end
