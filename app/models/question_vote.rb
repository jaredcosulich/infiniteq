class QuestionVote < ApplicationRecord

  belongs_to :question
  belongs_to :user

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_question


  private

  def set_trust
    t = user.present? ? user.trust : 1
    self.trust = (positive == 'false' ? t * -1 : t)
  end

  def update_question
    question.update_votes
  end

end
