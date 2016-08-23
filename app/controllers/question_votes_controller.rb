class QuestionVotesController < ApplicationController
  before_action :set_question
  before_action :set_question_vote, only: [:show, :edit, :update, :destroy]

  # POST /question_votes
  # POST /question_votes.json
  def create
    @question_vote = @question.question_votes.new(question_vote_params.merge(user: current_user))

    respond_to do |format|
      if @question_vote.save
        format.html {
          if @question_vote.user.present?
            render @question
          else
            update_temporary_user(@question_vote)
            redirect_to join_path(o: 'QuestionVote', i: @question_vote.id)
          end
        }
        format.json { render :show, status: :created, location: @question_vote }
      else
        format.html { render :new }
        format.json { render json: @question_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_votes/1
  # DELETE /question_votes/1.json
  def destroy
    @question_vote.destroy

    respond_to do |format|
      format.html { render @question, notice: 'Question vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.friendly.find(params[:question_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_question_vote
      @question_vote = @question.question_votes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_vote_params
      params.require(:question_vote).permit(:question_id, :positive)
    end

    def update_temporary_user(question_vote)
      temporary_user = TemporaryUser.find_or_create_by(ip_address: request.remote_ip)
      temporary_user.add_vote(question_vote)
    end

end
