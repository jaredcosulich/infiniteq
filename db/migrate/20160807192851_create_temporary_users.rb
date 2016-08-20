class CreateTemporaryUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :temporary_users do |t|
      t.string :ip_address
      t.text :votes
      t.text :questions
      t.text :answers

      t.timestamps
    end
  end
end
