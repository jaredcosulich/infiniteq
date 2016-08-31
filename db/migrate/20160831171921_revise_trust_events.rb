class ReviseTrustEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :trust_events, :event_object_id, :object_id
    add_column :trust_events, :object_type, :string
  end
end
