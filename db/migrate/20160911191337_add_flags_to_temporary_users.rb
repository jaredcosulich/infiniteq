class AddFlagsToTemporaryUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :temporary_users, :flags, :text
  end
end
