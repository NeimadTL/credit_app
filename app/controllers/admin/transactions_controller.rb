class Admin::TransactionsController < ApplicationController


  before_action :authenticate_user!


  def index
    @transactions = Transaction.all
  end


  def new
    @transaction = Transaction.new
  end


  def create
    bank_account = BankAccount.find(params[:transaction][:bank_account_id])
    @transaction = bank_account.transactions.create(transaction_params)

    if @transaction.valid?
      if @transaction.transaction_state.state_tid == TransactionState::VALIDATED_STATE_TID
        if @transaction.transaction_type.eql? Transaction::CREDIT_TRANSACTION_TYPE
          add_value_to_balance(@transaction)
        else
          substract_value_from_balance(@transaction)
        end
      end
      flash[:notice] = 'Transaction crée avec succès'
      redirect_to admin_transactions_path
    else
      render :new, status: :unprocessable_entity
    end

  end


  private

    def transaction_params
      params.require(:transaction).permit(:transaction_type, :state_tid, :bank_account_id, :value)
    end

    def add_value_to_balance(transaction)
      bank_account = BankAccount.find(transaction.bank_account_id)
      balance = bank_account.balance
      balance = balance + transaction.value
      saved = bank_account.update_attributes(balance: balance)
    end

    def substract_value_from_balance(transaction)
      bank_account = BankAccount.find(transaction.bank_account_id)
      balance = bank_account.balance
      balance = balance - transaction.value
      saved = bank_account.update_attributes(balance: balance)
    end

end
