class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :question
  belongs_to :answer
  belongs_to :parent_comment, class_name: 'Comment', foreign_key: :parent_comment_id
  has_many   :child_comments, class_name: 'Comment', foreign_key: :parent_comment_id

  def parent
    [question, answer, parent_comment].compact.first
  end

  def root_parent
    p = self
    while p.try(:parent).present?
      p = p.parent
    end
    p = p.question if p.is_a?(Answer)
    return p
  end

end
