class BankAccount < ActiveRecord::Base


  validates :branch_code, presence: true, format: { with: /\A[0-9]{5}\z/ }
  validates :sort_code, presence: true, format: { with: /\A[0-9]{5}\z/ }
  validates :account_number, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]{11}\z/ }
  validates :rib_key, presence: true, format: { with: /\A[0-9]{2}\z/ }

  belongs_to :account_state, foreign_key: "account_state_id"
  belongs_to :user
  has_many :transactions, :dependent => :destroy

  after_create :setup_default_account_state

  private

    def setup_default_account_state
      self.update_attributes(account_state_id: AccountState::PENDING_ACTIVATION_STATE_TID)
    end


end
