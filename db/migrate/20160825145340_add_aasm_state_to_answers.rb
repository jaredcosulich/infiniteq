class AddAasmStateToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :aasm_state, :string
  end
end
