class TransactionState < ActiveRecord::Base

  validates :state_tid, presence: true, numericality: { only_integer: true }
  validates :state, presence: true

end
