class CreateTrustEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :trust_events do |t|
      t.integer :user_id
      t.integer :trust
      t.integer :event_type, default: 0, null: false
      t.integer :event_object_id
      t.integer :event_user_id

      t.timestamps
    end
  end
end
