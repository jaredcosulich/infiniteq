class AddDisputeToFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :flags, :dispute, :boolean, default: false
  end
end
