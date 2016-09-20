class QuestionVote < ApplicationRecord
  include Vote

  belongs_to :question
  belongs_to :user

  attr_accessor :positive

  before_save :set_trust
  after_commit :update_question
  after_create :create_trust_event
  has_many :trust_events, -> { where(object_type: 'QuestionVote') }, foreign_key: :object_id, dependent: :destroy

  def topic
    'Question'
  end

  def topic_id
    question_id
  end

  def total_identifier
    "question_vote-#{id}"
  end

  private

  def update_question
    question.update_votes
  end

  def create_trust_event
    params = {object_type: 'QuestionVote', object_id: id, event_user: user}
    if question.user.present?
      question.user.trust_events.question_vote_created.create(
        params.merge(trust: trust / 10.0)
      )
    end

    if user.present?
      user.trust_events.question_vote_created.create(
        params.merge(trust: 1)
      )
    end
  end
end
