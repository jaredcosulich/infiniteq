class AddSlugs < ActiveRecord::Migration[5.0]
  def change

    add_column :topics, :slug, :string, unique: true
    add_column :questions, :slug, :string, unique: true

  end
end
