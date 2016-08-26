class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :question
  belongs_to :answer
  belongs_to :parent_comment, class_name: 'Comment', foreign_key: :parent_comment_id

  def parent
    [question, answer, parent_comment].compact.first
  end

end
