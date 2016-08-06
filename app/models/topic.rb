class Topic < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :questions

  belongs_to :parent_topic, class_name: 'Topic', foreign_key: :parent_topic_id
  has_many :subtopics, class_name: 'Topic', foreign_key: :parent_topic_id

  scope 'parent_topics', -> { where(parent_topic: nil) }
  scope 'most_questions', -> { order(recursive_questions_count: :desc) }

  after_commit :update_recursive_subtopic_ids, on: [:create, :destroy]
  after_update :update_recursive_subtopic_ids

  def all_questions
    Question.for_topics(recursive_subtopic_ids.split(','))
  end

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

  def update_recursive_subtopic_ids
    ids = []
    subtopics.each do |st|
      ids << st.id
      if st.recursive_subtopic_ids.present?
        ids.concat st.recursive_subtopic_ids.split(',').map(&:to_i)
      end
    end

    ids_string = ids.uniq.sort.join(',')

    if recursive_subtopic_ids != ids_string
      update_column :recursive_subtopic_ids, ids_string rescue nil
    end

    if parent_topic.present? || parent_topic_id_was.present?
      if parent_topic_id_was.present? && parent_topic_id != parent_topic_id_was
        previous_parent = Topic.find_by(id: parent_topic_id_was)
      end
      self.reload rescue nil
      parent_topic.update_recursive_subtopic_ids if parent_topic.present?
      previous_parent.update_recursive_subtopic_ids if previous_parent.present?
    end
  end
end
