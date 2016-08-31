class TrustEvent < ApplicationRecord

  belongs_to :user
  belongs_to :event_user, class_name: 'User', foreign_key: :event_user_id

  enum event_type: [ :question_created, :answer_created, :question_vote_created, :answer_vote_created ]

  def event_object_type
    case event_type
      when 'question_created'
        Question
      when 'answer_created'
        Answer
      when 'question_vote_created'
        QuestionVote
      when 'answer_vote_created'
        AnswerVote
    end
  end

  def object
    object_type.find_by(id: object_id)
  end
end
