class Answer < ApplicationRecord
  include Votable

  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :answer_votes

  default_scope { order(vote_total: :desc, created_at: :desc) }
  scope :persisted, -> { where "id IS NOT NULL" }

  after_create :update_votes

end
