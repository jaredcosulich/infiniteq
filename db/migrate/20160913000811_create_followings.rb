class CreateFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :topic_id
      t.integer :question_id

      t.timestamps
    end
  end
end
