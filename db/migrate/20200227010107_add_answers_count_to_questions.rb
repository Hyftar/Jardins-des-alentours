class AddAnswersCountToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :answers_count, :integer
  end
end
