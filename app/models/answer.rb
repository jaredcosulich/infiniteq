class Answer < ApplicationRecord
  include Votable

  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :answer_votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  default_scope { order(vote_total: :desc, created_at: :desc) }
  scope :persisted, -> { where "id IS NOT NULL" }

  after_create :update_votes
  after_create :create_trust_event
  after_save :transition_states

  include AASM
  aasm do
    state :unverified, :initial => true
    state :verified
    state :flagged
    state :suspect
    state :deleted

    event :verify do
      transitions :from => [:unverified, :suspect], :to => :verified
    end

    event :unverify do
      transitions :from => [:verified, :suspect], :to => :unverified
    end

    event :mark_suspect do
      transitions :from => [:unverified, :verified], :to => :suspect
    end

    event :mark_deleted do
      transitions :from => [:unverified, :suspect, :verified], :to => :deleted
    end
  end

  private
    def create_trust_event
      return if user.nil?
      user.trust_events.answer_created.create(event_object_id: id, trust: 1, event_user: user)
    end


end
