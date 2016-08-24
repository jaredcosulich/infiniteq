class Question < ApplicationRecord
  include Votable
  extend FriendlyId
  friendly_id :text, use: :slugged

  belongs_to :user
  belongs_to :topic, counter_cache: true
  has_many :answers
  has_many :question_votes

  default_scope { order(vote_total: :desc, created_at: :desc) }
  scope :persisted, -> { where "id IS NOT NULL" }
  scope :unanswered, -> { where(answers_count: 0) }
  scope :for_topics, -> (topic_ids) { where('topic_id in (?)', topic_ids) }

  after_commit :update_topic_recursive_question_count, on: [:create, :destroy]
  after_create :update_votes

  include AASM
  aasm do
    state :unverified, :initial => true
    state :flagged
    state :suspect
    state :verified
    state :deleted

    event :verify do
      transitions :from => [:anonymous, :suspect], :to => :verified
    end

    event :flag do
      transitions :from => [:anonymous, :verified], :to => :suspect
    end

    event :mark_deleted do
      transitions :from => [:anonymous, :suspect, :verified], :to => :deleted
    end
  end

  private
  def update_topic_recursive_question_count
    return if topic.nil?
    topic.update_recursive_questions_count
  end
end
