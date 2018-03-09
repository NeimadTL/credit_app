class Transaction < ActiveRecord::Base


  validates :transaction_type, presence: true, inclusion: { in: %w(Crédit Débit) }
  validates :state_tid, presence: true
  validates :value, presence: true, numericality: true

  belongs_to :bank_account
  belongs_to :transaction_state, foreign_key: "state_tid"


end
