class UsersController < ApplicationController
  skip_after_action :set_return_to

  def show
    @user = User.find(params[:id])
  end

end
