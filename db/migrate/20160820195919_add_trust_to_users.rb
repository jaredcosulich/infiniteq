class AddTrustToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :trust, :integer, default: 0
  end
end
