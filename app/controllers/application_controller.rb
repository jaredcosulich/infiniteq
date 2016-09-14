class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_temporary_user
  after_action :set_return_to

  private
    def find_temporary_user
      return if user_signed_in?
      @temporary_user = TemporaryUser.where(ip_address: request.remote_ip).first || TemporaryUser.new
    end

    def set_return_to
      session[:return_to] = request.path
    end
end
