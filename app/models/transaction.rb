class Transaction < ActiveRecord::Base


  validates :type, presence: true, inclusion: { in: %w(Crédit Débit) }
  validates :transaction_state, presence: true

  belongs_to :bank_account


end
