class AnswerVote < ApplicationRecord

  belongs_to :answer
  belongs_to :user

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_answer
  after_create :create_trust_event
  has_many :trust_events, -> { where(object_type: 'AnswerVote') }, foreign_key: :object_id, dependent: :destroy


  def topic
    'Answer'
  end

  def topic_id
    answer_id
  end

  def positive?
    trust > 0
  end

  private

  def set_trust
    t = user.present? ? (user.trust > 0 ? user.trust : 0) : 10
    self.trust = (positive == 'false' ? t * -1 : t)
  end

  def update_answer
    answer.update_votes unless answer.destroyed?
  end

  def create_trust_event
    params = {object_type: 'AnswerVote', object_id: id, event_user: user}
    if answer.user.present?
      answer.user.trust_events.answer_vote_created.create(
        params.merge(trust: trust / 10.0)
      )
    end

    if user.present?
      user.trust_events.answer_vote_created.create(
        params.merge(trust: 1)
      )
    end
  end

end
