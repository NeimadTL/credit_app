class TransactionManager


  def initialize(transaction)
    @transaction = transaction
  end

  def execute_transaction
    if @transaction.transaction_state.state_tid == TransactionState::VALIDATED_STATE_TID
      if @transaction.transaction_type.eql? Transaction::CREDIT_TRANSACTION_TYPE
        add_value_to_balance
      else
        substract_value_from_balance
      end
    end
  end


  private

    def add_value_to_balance
      balance = get_balance
      balance = balance + @transaction.value
      update_balance(balance)
    end

    def substract_value_from_balance
      balance = get_balance
      balance = balance - @transaction.value
      update_balance(balance)
    end

    def get_balance
      bank_account = BankAccount.find(@transaction.bank_account_id)
      bank_account.balance
    end

    def update_balance(new_balance)
      bank_account = BankAccount.find(@transaction.bank_account_id)
      bank_account.update_attributes(balance: new_balance)
    end


end
