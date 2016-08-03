class AddQuestionCountToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :questions_count, :integer, default: 0
    add_column :topics, :recursive_questions_count, :integer, default: 0
  end
end
