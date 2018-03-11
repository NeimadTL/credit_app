class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # redirect to right the url according to user role
  def after_sign_in_path_for(resource_or_scope)
    if current_user.role.role_tid == Role::CLIENT_ROLE_TID
      client_bank_accounts_url
    elsif current_user.role.role_tid == Role::ADMIN_ROLE_TID
      admin_transactions_url
    end
  end


end
