class AccountState < ActiveRecord::Base

  self.primary_key = 'state_tid'

  PENDING_ACTIVATION_STATE_TID = 1
  ACTIVE_STATE_TID = 2
  CLOSED_STATE_TID = 3

  validates :state_tid, presence: true, numericality: { only_integer: true }
  validates :state, presence: true


end
