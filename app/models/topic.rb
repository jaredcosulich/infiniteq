class Topic < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :questions

  belongs_to :parent_topic, class_name: 'Topic', foreign_key: :parent_topic_id
  has_many :subtopics, class_name: 'Topic', foreign_key: :parent_topic_id

  scope 'parent_topics', -> { where(parent_topic: nil) }

  def parent_path
    return [] if (p = parent_topic).nil?
    parents = []
    loop do
      parents << p
      p = p.parent_topic
      break if p.nil?
    end
    return parents
  end

end
