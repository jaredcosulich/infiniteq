class Admin::AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_admin
  layout 'admin'

  def index
  end

  private
    def check_admin
      current_user.id == 1
    end

end
