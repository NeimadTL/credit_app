class Admin::TransactionsController < ApplicationController


  before_action :authenticate_user!
  before_action :require_to_be_admin
  before_action :set_transaction, only: [:update]


  def index
    @transactions = Transaction.all.order(created_at: :desc)
      .paginate(:page => params[:page], :per_page => 5)
  end


  def new
    @transaction = Transaction.new
  end


  def create
    begin
      bank_account = BankAccount.find(params[:transaction][:bank_account_id])
      @transaction = bank_account.transactions.create(transaction_params)
      if @transaction.valid?
        TransactionManager.new(@transaction).execute_transaction
        flash[:notice] = 'Transaction crée avec succès'
        redirect_to admin_transactions_path
      else
        render :new, status: :unprocessable_entity
      end
    rescue BankAccountError => e
      flash[:alert] = e.message
      @transaction.destroy
      render :new
    end
  end


  def update
    begin
      @transaction.update_attributes(transaction_params)
      if @transaction.valid?
        TransactionManager.new(@transaction).execute_transaction
        flash[:notice] = 'Transaction mise à jour avec succès'
      else
        flash[:alert] = 'Une erreur est survenue'
      end
    rescue BankAccountError => e
      flash[:alert] = e.message
      @transaction.update_attributes(state_tid: TransactionState::PENDING_STATE_TID)
    end
    redirect_to admin_transactions_path
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

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end
end
