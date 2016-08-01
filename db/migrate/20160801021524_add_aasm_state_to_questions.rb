class AddAasmStateToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :aasm_state, :string
  end
end
