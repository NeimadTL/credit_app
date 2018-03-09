class TransactionState < ActiveRecord::Base

  self.primary_key = 'state_tid'
  
  validates :state_tid, presence: true, numericality: { only_integer: true }
  validates :state, presence: true

end
