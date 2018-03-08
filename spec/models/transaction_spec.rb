require 'rails_helper'

RSpec.describe Transaction, type: :model do

  it { should validate_presence_of :type }
  it { should validate_presence_of :transaction_state }
  it { is_expected.to belong_to(:bank_account) }

end
