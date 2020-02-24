class AddStatusToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :status, :integer, default: 0, null: false
  end
end
