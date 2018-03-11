require 'rails_helper'

RSpec.describe Role, type: :model do

  it { should validate_presence_of :role_tid }
  it { should validate_numericality_of(:role_tid) }
  it { should validate_presence_of :role_label }

end
