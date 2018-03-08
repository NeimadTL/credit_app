require 'rails_helper'

RSpec.describe BankAccount, type: :model do

  User.delete_all
  range = MonthlySalaryRange.first
  user = User.create!(title: "Mr", firstname: "John", lastname: "Doe",
    city: "San Francisco", birthday: "22/12/1992", monthly_salary_range_id: range.id,
    email: "something@gmail.com", password: "12345678", password_confirmation: "12345678")

  let(:bank_account) {
    BankAccount.create!(branch_code: "92833", sort_code: "02939", account_number: "9384927463Y",
      rib_key: "26", user_id: user.id);
    }

  it { should validate_presence_of :branch_code }
  it { should_not allow_value("abcde").for(:branch_code) }
  it { should_not allow_value("0e99a").for(:branch_code) }
  it { should_not allow_value("3").for(:branch_code) }
  it { should_not allow_value("93").for(:branch_code) }
  it { should_not allow_value("3737283").for(:branch_code) }
  it { should allow_value("37372").for(:branch_code) }

  it { should validate_presence_of :sort_code }
  it { should_not allow_value("abcde").for(:sort_code) }
  it { should_not allow_value("0e99a").for(:sort_code) }
  it { should_not allow_value("3").for(:sort_code) }
  it { should_not allow_value("93").for(:sort_code) }
  it { should_not allow_value("3737283").for(:sort_code) }
  it { should allow_value("37372").for(:sort_code) }

  it { should validate_presence_of :account_number }
  it { should validate_uniqueness_of(:account_number) }
  it { should_not allow_value("0e99aD93AIZID").for(:account_number) }
  it { should_not allow_value("0e99a").for(:account_number) }
  it { should allow_value("0e99a0e99la").for(:account_number) }
  it { should allow_value("0E99A0E99LA").for(:account_number) }
  it { should allow_value("0E99a0e99LA").for(:account_number) }
  it { should allow_value("83929384739").for(:account_number) }
  it { should allow_value("eodkslzceug").for(:account_number) }
  it { should allow_value("EODKSLZCEUG").for(:account_number) }

  it { should validate_presence_of :rib_key }
  it { should_not allow_value("ab").for(:rib_key) }
  it { should_not allow_value("AB").for(:rib_key) }
  it { should_not allow_value("abc").for(:rib_key) }
  it { should_not allow_value("ABC").for(:rib_key) }
  it { should_not allow_value("1").for(:rib_key) }
  it { should_not allow_value("123").for(:rib_key) }
  it { should allow_value("12").for(:rib_key) }


  it { is_expected.to belong_to(:account_state) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to callback(:setup_default_account_state).after(:create) }

  describe "when bank account is created, #setup_default_account_state should
    set account state to 'en attente d\'activation'" do
    it { expect(bank_account.account_state.state).to eql 'en attente d\'activation' }
  end

end
