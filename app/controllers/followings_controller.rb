class FollowingsController < ApplicationController
  before_action :set_following, only: [:destroy]

  # POST /followings
  # POST /followings.json
  def create
    @following = Following.new(following_params.merge(user: current_user))

    respond_to do |format|
      if @following.save
        format.html { redirect_to @following.object, notice: "You are now following this #{@following.object.class.to_s.downcase}." }
        format.json { render :show, status: :created, location: @following }
      else
        format.html { redirect_to @following.object, notice: "There was an error following this #{@following.object.class.to_s.downcase}. Please try again in a few minutes." }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    object = @following.object
    @following.destroy
    respond_to do |format|
      format.html { redirect_to object, notice: "You are no longer following this #{object.class.to_s}." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:following).permit(:user_id, :topic_id, :question_id)
    end
end
