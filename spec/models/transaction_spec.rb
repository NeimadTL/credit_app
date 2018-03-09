require 'rails_helper'

RSpec.describe Transaction, type: :model do

  it { should validate_presence_of :transaction_type }
  it { should validate_presence_of :state_tid }
  it { is_expected.to belong_to(:bank_account) }
  it { is_expected.to belong_to(:transaction_state) }
  it { should validate_presence_of :value }
  it { should validate_numericality_of(:value) }
  
end
