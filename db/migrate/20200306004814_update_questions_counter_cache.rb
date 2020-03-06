class UpdateQuestionsCounterCache < ActiveRecord::Migration[6.0]
  def change
    change_column_null :questions, :answers_count, false
    change_column_default :questions, :answers_count, from: nil, to: 0
  end
end
