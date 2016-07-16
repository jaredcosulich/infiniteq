class WelcomeController < ApplicationController
  def index

    @topics = Topic.all.sort

  end
end
