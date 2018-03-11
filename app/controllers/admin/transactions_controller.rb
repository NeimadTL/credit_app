class Admin::TransactionsController < ApplicationController


  before_action :authenticate_user!
  before_action :require_to_be_admin


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
      TransactionManager.new(@transaction).execute_transaction
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

    def require_to_be_admin
      unless current_user.role.role_tid == Role::ADMIN_ROLE_TID
        render :file => "#{Rails.root}/public/401", :layout => false, :status => :unauthorized
      end
    end
end
