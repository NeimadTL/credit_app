class Transaction < ActiveRecord::Base


  CREDIT_TRANSACTION_TYPE = "Crédit"
  DEBIT_TRANSACTION_TYPE = "Débit"

  validates :transaction_type, presence: true, inclusion: { in: %w(Crédit Débit) }
  validates :state_tid, presence: true
  validates :value, presence: true, numericality: true

  belongs_to :bank_account
  belongs_to :transaction_state, foreign_key: "state_tid"

  def is_validated?
    state_tid == TransactionState::VALIDATED_STATE_TID
  end

  def is_credit_type?
    transaction_type.eql? Transaction::CREDIT_TRANSACTION_TYPE
  end

  def is_debit_type?
    transaction_type.eql? Transaction::DEBIT_TRANSACTION_TYPE
  end


end
