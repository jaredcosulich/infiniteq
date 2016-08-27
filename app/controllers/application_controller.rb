class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_temporary_user

  private
    def find_temporary_user
      return if user_signed_in?
      @temporary_user = TemporaryUser.where(ip_address: request.remote_ip).first || TemporaryUser.new
    end
end
