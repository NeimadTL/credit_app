class Admin::UsersController < ApplicationController


  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :require_to_be_admin

  def index
    @users = User.where(role_tid: Role::CLIENT_ROLE_TID)
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)

    if @user.valid?
      flash[:notice] = 'Client mis à jour avec succès'
      redirect_to admin_users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'Client supprimé avec succès'
    redirect_to admin_users_path
  end

  private

    def user_params
      params.require(:user).permit(:title, :firstname, :birthday, :email, :city, :monthly_salary_range_id)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_to_be_admin
      unless current_user.role.role_tid == Role::ADMIN_ROLE_TID
        render :file => "#{Rails.root}/public/401", :layout => false, :status => :unauthorized
      end
    end


end