class CustomisedRegistrationsController < Devise::RegistrationsController


  def create
    super
  end

  private

    def sign_up_params
      params.require(resource_name).permit(:title, :firstname, :lastname, :birthday, :city,
        :monthly_salary_range, :email, :password, :password_confirmation)
    end

end
