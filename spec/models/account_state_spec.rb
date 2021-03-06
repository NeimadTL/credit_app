require 'rails_helper'

RSpec.describe AccountState, type: :model do

  it { should validate_presence_of :state_tid }
  it { should validate_numericality_of(:state_tid) }
  it { should validate_presence_of :state }

end
