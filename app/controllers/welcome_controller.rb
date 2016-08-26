class WelcomeController < ApplicationController

  def index
    @topics = Topic.parent_topics.order(created_at: :desc)
    @questions = Question.order(created_at: :desc).limit(5)
  end

  def join
    @object = case params[:o]
      when 'QuestionVote'
        QuestionVote.find_by(id: params[:i])
      when 'AnswerVote'
        AnswerVote.find_by(id: params[:i])
      when 'Question'
        Question.find_by(id: params[:i])
      # when 'Answer'
      #   Answer.find_by(id: params[:i])
    end
  end
end
