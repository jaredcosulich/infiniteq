class Answer < ApplicationRecord

  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :answer_votes

  scope :persisted, -> { where "id IS NOT NULL" }

  def update_votes
    update_column :vote_total, answer_votes.sum(:trust)
  end

end
