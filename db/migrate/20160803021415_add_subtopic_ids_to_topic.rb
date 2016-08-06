class AddSubtopicIdsToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :recursive_subtopic_ids, :text
  end
end
