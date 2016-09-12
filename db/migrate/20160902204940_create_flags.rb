class CreateFlags < ActiveRecord::Migration[5.0]
  def change
    create_table :flags do |t|
      t.integer :reason
      t.integer :question_id
      t.integer :answer_id
      t.integer :user_id
      t.integer :trust
      t.text :details
      t.boolean :suspect, default: false
      t.boolean :confirmed
      t.integer :editor_id

      t.timestamps
    end
  end
end
