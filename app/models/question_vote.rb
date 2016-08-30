class QuestionVote < ApplicationRecord

  belongs_to :question
  belongs_to :user

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_question
  after_create :create_trust_event

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

  def create_trust_event
    params = {event_object_id: id, event_user: user}
    if question.user.present?
      question.user.trust_events.question_vote_created.create(
        params.merge(trust: trust)
      )
    end

    if user.present?
      user.trust_events.question_vote_created.create(
        params.merge(trust: 0)
      )
    end
  end
end
