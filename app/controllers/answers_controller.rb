class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  skip_after_action :set_return_to, only: [:create, :update, :destroy]

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params.merge(user: current_user))

    respond_to do |format|
      if @answer.save
        AdminMailer.object_created(@answer).deliver_now
        @answer.question.followings.each do |following|
          FollowingMailer.object_created(@answer, following).deliver_now
        end

        format.html do
          if @answer.user.present?
            redirect_to @answer.question, notice: 'Answer was successfully created.'
          else
            TemporaryUser.add_object(@answer, request.remote_ip)
            redirect_to join_path(o: 'Answer', i: @answer.id)
          end
        end
        format.json { render :show, status: :created, location: @answer }
      else
        format.html do
          redirect_to @answer.question, notice: "There were problems with your answer: #{@answer.errors.full_messages.join(', ')}"
        end
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    answer_params[:text] = answer_params[:text].gsub(/\n/, '')
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    question = @answer.question
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:text, :question_id, :user_id)
    end
end
