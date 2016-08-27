class QuestionVote < ApplicationRecord

  belongs_to :question
  belongs_to :user

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_question

  def topic
    'Question'
  end

  def topic_id
    question_id
  end

  private

  def set_trust
    return if positive.blank?
    t = user.present? ? user.trust : 1
    self.trust = (positive == 'false' ? t * -1 : t)
  end

  def update_question
    question.update_votes
  end

end
