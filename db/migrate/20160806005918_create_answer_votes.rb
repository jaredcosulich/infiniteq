class CreateAnswerVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_votes do |t|
      t.integer :answer_id
      t.integer :user_id
      t.integer :trust

      t.timestamps
    end

    add_column :answers, :vote_total, :integer, default: 0

  end
end
