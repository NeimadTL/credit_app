require 'rails_helper'

RSpec.describe BankAccount, type: :model do

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


  it { should validate_presence_of :account_state }

end
