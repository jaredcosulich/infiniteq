class WelcomeController < ApplicationController
  def index

    @topics = Topic.parent_topics.sort

  end
end
