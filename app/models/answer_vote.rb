class AnswerVote < ApplicationRecord

  belongs_to :answer

  attr_accessor :positive

end
