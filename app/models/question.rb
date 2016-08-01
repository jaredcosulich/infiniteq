class Question < ApplicationRecord
  extend FriendlyId
  friendly_id :text, use: :slugged

  belongs_to :topic
  has_many :answers

  scope :persisted, -> { where "id IS NOT NULL" }

  include AASM
  aasm do
    state :anonymous, :initial => true
  end
end
