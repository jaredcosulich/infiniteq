class TrustEvent < ApplicationRecord

  belongs_to :user
  belongs_to :event_user, class_name: 'User', foreign_key: :event_user_id

  enum event_type: [ :question_created, :answer_created, :question_vote_created, :answer_vote_created ]

  def event_object_type
    case event_type
      when 'question_created'
        Question
    end
  end

  def event_object
    event_object_type.find_by(id: event_object_id)
  end
end
