class Question < ApplicationRecord
  include Votable
  extend FriendlyId
  friendly_id :text, use: :slugged

  validates :text, presence: true

  belongs_to :user
  belongs_to :topic, counter_cache: true
  has_many :answers
  has_many :question_votes
  has_many :comments
  has_many :trust_events, -> { where(object_type: 'Question') }, foreign_key: :object_id, dependent: :destroy
  has_many :flags
  has_many :followings

  paginates_per 10

  default_scope { order(vote_total: :desc, created_at: :desc) }
  scope :persisted, -> { where "id IS NOT NULL" }
  scope :unanswered, -> { where(answers_count: 0) }
  scope :for_topics, -> (topic_ids) { where('topic_id in (?)', topic_ids) }
  scope :today, -> { where('created_at > ?', 1.day.ago) }
  scope :this_week, -> { where('created_at > ?', 7.days.ago) }

  after_commit :update_topic_recursive_question_count, on: [:create, :destroy]
  after_create :update_votes
  after_create :create_trust_event
  after_save :transition_states

  include AASM
  aasm do
    state :verified
    state :unverified, :initial => true
    state :flagged
    state :suspect
    state :deleted

    event :verify do
      transitions :from => [:unverified], :to => :verified
    end

    event :unverify do
      transitions :from => [:verified], :to => :unverified
    end

    event :mark_suspect do
      transitions :from => [:unverified, :verified, :flagged], :to => :suspect
    end

    event :mark_deleted do
      transitions :from => [:unverified, :suspect, :verified], :to => :deleted
    end
  end

  def normalize_friendly_id(string)
    super[0..60]
  end

  def total_identifier
    "question-#{id}"
  end

  def owned_by?(user_or_temporary_user)
    return false if user_or_temporary_user.nil?
    if user_or_temporary_user.is_a?(TemporaryUser)
      user_or_temporary_user.owns_question?(self)
    else
      user_id == user_or_temporary_user.id
    end
  end

  private
    def update_topic_recursive_question_count
      return if topic.nil?
      topic.update_recursive_questions_count
    end

    def create_trust_event
      return if user.nil?
      user.trust_events.question_created.create(object_type: 'Question', object_id: id, trust: 10, event_user: user)
    end
end
