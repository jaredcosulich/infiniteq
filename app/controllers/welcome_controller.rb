class WelcomeController < ApplicationController

  def index
    @topics = Topic.parent_topics.order(created_at: :desc)
    @questions = Question.order(created_at: :desc).limit(5)
  end

  def join
    # @object = params[:o].
  end
end
