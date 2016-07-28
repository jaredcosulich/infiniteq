class Answer < ApplicationRecord

  belongs_to :question

  scope :persisted, -> { where "id IS NOT NULL" }

end
