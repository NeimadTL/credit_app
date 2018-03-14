class TransactionManager


  def initialize(transaction)
    @transaction = transaction
  end

  def execute_transaction
    if @transaction.is_credit_type?
      credit_account
    elsif @transaction.is_debit_type?
      debit_account
    end
  end

  private

    def credit_account
      bank_account = BankAccount.find(@transaction.bank_account_id)
      raise_error_if_bank_account_is_pending_activation_or_closed(bank_account)
      if @transaction.is_validated?
        if bank_account.is_active?
          increase_bank_account_balance(bank_account)
        end
      end
    end

    def increase_bank_account_balance(bank_account)
      balance = bank_account.balance
      balance = balance + @transaction.value
      bank_account.update_attributes(balance: balance)
    end

    def raise_error_if_bank_account_is_pending_activation_or_closed(bank_account)
      if bank_account.is_activation_pending?
        raise BankAccountError.new('Ce compte est en attente d\'activation')
      elsif bank_account.is_closed?
        raise BankAccountError.new('Ce compte est fermé')
      end
    end

    def debit_account
      bank_account = BankAccount.find(@transaction.bank_account_id)
      raise_error_if_bank_account_is_pending_activation_or_closed(bank_account)
      if @transaction.is_validated?
        if bank_account.is_active?
          decrease_bank_account_balance(bank_account)
        end
      end
    end

    def decrease_bank_account_balance(bank_account)
      balance = bank_account.balance
      balance = balance - @transaction.value
      bank_account.update_attributes(balance: balance)
    end


end
