class CreateQuestionVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :question_votes do |t|
      t.integer :question_id
      t.integer :user_id
      t.integer :trust

      t.timestamps
    end
  end

  add_column :questions, :vote_total, :integer, default: 0

end
