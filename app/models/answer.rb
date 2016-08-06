class Answer < ApplicationRecord

  belongs_to :question, counter_cache: true
  has_many :answer_votes

  scope :persisted, -> { where "id IS NOT NULL" }

end
