class Answer < ApplicationRecord

  belongs_to :question, counter_cache: true 

  scope :persisted, -> { where "id IS NOT NULL" }

end
