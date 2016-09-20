class AddProofToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :proof, :text
  end
end
