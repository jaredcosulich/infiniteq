class AddParentTopicIdToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :parent_topic_id, :integer
  end
end
