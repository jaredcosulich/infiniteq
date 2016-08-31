class TrustEvent < ApplicationRecord

  belongs_to :user
  belongs_to :event_user, class_name: 'User', foreign_key: :event_user_id

  enum event_type: [ :question_created, :answer_created, :question_vote_created, :answer_vote_created ]

  def object
    object_type.constantize.find_by(id: object_id)
  end
end
