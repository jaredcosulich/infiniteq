class Users::RegistrationsController < Devise::RegistrationsController
  skip_after_action :set_return_to
  
  private
    def after_sign_up_path_for(resource)
      post_process_registration
    end

    def after_inactive_sign_up_path_for(resource)
      post_process_registration
    end

    def post_process_registration
      session[:return_to] or root_path
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :ip_address, followings_attributes: [:topic_id, :question_id])
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end

end
