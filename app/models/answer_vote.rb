class AnswerVote < ApplicationRecord

  belongs_to :answer
  belongs_to :user

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_answer

  def topic
    'Answer'
  end

  def topic_id
    answer_id
  end

  private

  def set_trust
    t = user.present? ? user.trust : 1
    self.trust = (positive == 'false' ? t * -1 : t)
  end

  def update_answer
    answer.update_votes
  end

end
