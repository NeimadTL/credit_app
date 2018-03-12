class Client::BankAccountsController < ApplicationController


  before_action :authenticate_user!
  before_action :set_bank_account, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def index
    @bank_accounts = BankAccount.where(user_id: current_user.id)
  end


  def new
    @bank_account = BankAccount.new
  end


  def create
    @bank_account = current_user.bank_accounts.create(bank_account_params.merge(user: current_user))

    if @bank_account.valid?
      flash[:notice] = 'Compte crée avec succès'
      redirect_to client_bank_accounts_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @transactions = @bank_account.transactions.order(created_at: :desc)
      .paginate(:page => params[:page], :per_page => 5)
  end


  private

    def bank_account_params
      params.require(:bank_account).permit(:branch_code, :sort_code, :account_number, :rib_key)
    end

    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    def not_found(e)
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end


end
