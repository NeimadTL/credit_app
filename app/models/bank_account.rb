class BankAccount < ActiveRecord::Base


  validates :branch_code, presence: true, format: { with: /\A[0-9]{5}\z/ }
  validates :sort_code, presence: true, format: { with: /\A[0-9]{5}\z/ }
  validates :account_number, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]{11}\z/ }
  validates :rib_key, presence: true, format: { with: /\A[0-9]{2}\z/ }

  belongs_to :account_state
  belongs_to :user

  after_create :setup_default_account_state

  PENDING_ACTIVATION = 'en attente d\'activation'

  private

    def setup_default_account_state
      account_state = AccountState.where(state: PENDING_ACTIVATION).first
      self.update_attributes(account_state_id: account_state.id)
    end


end
