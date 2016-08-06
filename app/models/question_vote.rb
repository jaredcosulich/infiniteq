class QuestionVote < ApplicationRecord

  belongs_to :question

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_question
  

  private

  def set_trust
    self.trust = (positive == 'false' ? -1 : 1)
  end

  def update_question
    question.update_votes
  end

end
