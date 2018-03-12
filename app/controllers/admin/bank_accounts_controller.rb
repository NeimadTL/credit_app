class Admin::BankAccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_bank_account
  before_action :require_to_be_admin


  def update
    @bank_account.update_attributes(bank_account_params)

    if @bank_account.valid?
      flash[:notice] = 'Compte mis à jour avec succès'
      # redirect_to admin_user_path @bank_account.user
    else
      flash[:alert] = 'Une erreur est survenue'
    end
    redirect_to admin_user_path @bank_account.user
  end

  private

    def bank_account_params
      params.require(:bank_account).permit(:account_state_id)
    end

    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    def require_to_be_admin
      unless current_user.role.role_tid == Role::ADMIN_ROLE_TID
        render :file => "#{Rails.root}/public/401", :layout => false, :status => :unauthorized
      end
    end

end
