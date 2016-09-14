class TemporaryUsersController < ApplicationController
  before_action :set_temporary_user, only: [:show, :edit, :update, :destroy]
  skip_after_action :set_return_to

  # GET /temporary_users
  # GET /temporary_users.json
  def index
    @temporary_users = TemporaryUser.all
  end

  # GET /temporary_users/1
  # GET /temporary_users/1.json
  def show
  end

  # GET /temporary_users/new
  def new
    @temporary_user = TemporaryUser.new
  end

  # GET /temporary_users/1/edit
  def edit
  end

  # POST /temporary_users
  # POST /temporary_users.json
  def create
    @temporary_user = TemporaryUser.new(temporary_user_params)

    respond_to do |format|
      if @temporary_user.save
        format.html { redirect_to @temporary_user, notice: 'Temporary user was successfully created.' }
        format.json { render :show, status: :created, location: @temporary_user }
      else
        format.html { render :new }
        format.json { render json: @temporary_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temporary_users/1
  # PATCH/PUT /temporary_users/1.json
  def update
    respond_to do |format|
      if @temporary_user.update(temporary_user_params)
        format.html { redirect_to @temporary_user, notice: 'Temporary user was successfully updated.' }
        format.json { render :show, status: :ok, location: @temporary_user }
      else
        format.html { render :edit }
        format.json { render json: @temporary_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temporary_users/1
  # DELETE /temporary_users/1.json
  def destroy
    @temporary_user.destroy
    respond_to do |format|
      format.html { redirect_to temporary_users_url, notice: 'Temporary user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temporary_user
      @temporary_user = TemporaryUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temporary_user_params
      params.require(:temporary_user).permit(:ip_address, :votes, :questions, :answers)
    end
end
