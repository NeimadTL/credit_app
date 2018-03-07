class BankAccount < ActiveRecord::Base


  validates :branch_code, presence: true, format: { with: /\A[0-9]{5}\z/ }
  validates :sort_code, presence: true, format: { with: /\A[0-9]{5}\z/ }
  validates :account_number, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]{11}\z/ }
  validates :rib_key, presence: true, format: { with: /\A[0-9]{2}\z/ }
  validates :account_state, presence: true


end
