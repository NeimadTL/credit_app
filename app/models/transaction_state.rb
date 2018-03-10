class TransactionState < ActiveRecord::Base

  self.primary_key = 'state_tid'

  PENDING_STATE_TID = 1
  CANCELLED_STATE_TID = 2
  VALIDATED_STATE_TID = 3

  validates :state_tid, presence: true, numericality: { only_integer: true }
  validates :state, presence: true

end
