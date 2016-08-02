class Question < ApplicationRecord
  extend FriendlyId
  friendly_id :text, use: :slugged

  belongs_to :topic
  has_many :answers

  scope :persisted, -> { where "id IS NOT NULL" }
  scope :unanswered, -> { where(answers_count: 0) }

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
end
