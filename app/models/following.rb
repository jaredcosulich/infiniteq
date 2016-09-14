class Following < ApplicationRecord

  belongs_to :user
  belongs_to :topic
  belongs_to :question

  def object
    topic || question
  end

end
