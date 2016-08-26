class AnswerVotesController < ApplicationController
  before_action :set_answer
  before_action :set_answer_vote, only: [:show, :edit, :update, :destroy]

  # POST /answer_votes
  # POST /answer_votes.json
  def create
    if user_signed_in?
      @answer_vote = current_user.answer_votes.find_by(answer_id: @answer.id)
    end

    if @answer_vote.present?
      @answer_vote.assign_attributes(answer_vote_params)
    else
      @answer_vote = @answer.answer_votes.new(answer_vote_params.merge(user: current_user))
    end

    respond_to do |format|
      if @answer_vote.save
        format.html {
          if @answer_vote.user.present?
            render @answer.reload
          else
            update_temporary_user(@answer_vote)
            redirect_to join_path(o: 'AnswerVote', i: @answer_vote.id)
          end
        }
        format.json { render :show, status: :created, location: @answer_vote }
      else
        format.html { render :new }
        format.json { render json: @answer_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_votes/1
  # DELETE /answer_votes/1.json
  def destroy
    @answer_vote.destroy

    respond_to do |format|
      format.html { render @answer, notice: 'answer vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:answer_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_answer_vote
      @answer_vote = @answer.answer_votes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_vote_params
      params.require(:answer_vote).permit(:answer_id, :positive)
    end

    def update_temporary_user(answer_vote)
      temporary_user = TemporaryUser.find_or_create_by(ip_address: request.remote_ip)
      temporary_user.add_vote(answer_vote)
    end

end
