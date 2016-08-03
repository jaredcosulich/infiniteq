class Topic < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :questions

  belongs_to :parent_topic, class_name: 'Topic', foreign_key: :parent_topic_id
  has_many :subtopics, class_name: 'Topic', foreign_key: :parent_topic_id

  scope 'parent_topics', -> { where(parent_topic: nil) }
  scope 'most_questions', -> { order(recursive_questions_count: :desc) }

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

  def update_recursive_questions_count
    count = subtopics.inject(questions_count) do |total, subtopic|
      total += subtopic.recursive_questions_count
    end
    update_column(:recursive_questions_count, count)

    if parent_topic.present?
      parent_topic.update_recursive_questions_count
    end
  end
end
