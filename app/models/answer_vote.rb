class AnswerVote < ApplicationRecord

  belongs_to :answer
  belongs_to :user

  attr_accessor :positive

  def topic
    'Answer'
  end

  def topic_id
    answer_id
  end

end
