class Users::RegistrationsController < Devise::RegistrationsController

  private

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :ip_address)
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end

end
