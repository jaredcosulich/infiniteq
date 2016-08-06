class AnswerVotesController < ApplicationController
  before_action :set_answer_vote, only: [:show, :edit, :update, :destroy]

  # GET /answer_votes
  # GET /answer_votes.json
  def index
    @answer_votes = AnswerVote.all
  end

  # GET /answer_votes/1
  # GET /answer_votes/1.json
  def show
  end

  # GET /answer_votes/new
  def new
    @answer_vote = AnswerVote.new
  end

  # GET /answer_votes/1/edit
  def edit
  end

  # POST /answer_votes
  # POST /answer_votes.json
  def create
    @answer_vote = AnswerVote.new(answer_vote_params)

    respond_to do |format|
      if @answer_vote.save
        format.html { redirect_to @answer_vote, notice: 'Answer vote was successfully created.' }
        format.json { render :show, status: :created, location: @answer_vote }
      else
        format.html { render :new }
        format.json { render json: @answer_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answer_votes/1
  # PATCH/PUT /answer_votes/1.json
  def update
    respond_to do |format|
      if @answer_vote.update(answer_vote_params)
        format.html { redirect_to @answer_vote, notice: 'Answer vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer_vote }
      else
        format.html { render :edit }
        format.json { render json: @answer_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_votes/1
  # DELETE /answer_votes/1.json
  def destroy
    @answer_vote.destroy
    respond_to do |format|
      format.html { redirect_to answer_votes_url, notice: 'Answer vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_vote
      @answer_vote = AnswerVote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_vote_params
      params.require(:answer_vote).permit(:answer_id, :user_id, :trust)
    end
end
