class Answer < ApplicationRecord

  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :answer_votes

  default_scope { order(vote_total: :desc, created_at: :desc) }
  scope :persisted, -> { where "id IS NOT NULL" }

  def update_votes
    update_column :vote_total, answer_votes.sum(:trust)
  end

end
