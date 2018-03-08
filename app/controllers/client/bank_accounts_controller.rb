class Client::BankAccountsController < ApplicationController


  before_action :authenticate_user!


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


  private

    def bank_account_params
      params.require(:bank_account).permit(:branch_code, :sort_code, :account_number, :rib_key)
    end


end
