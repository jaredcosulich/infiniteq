class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :text
      t.text :details
      t.integer :topic_id
      t.integer :answer_id
      t.integer :user_id

      t.timestamps
    end
  end
end
