class CreateQuestionVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :question_votes do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :vote, null: false

      t.timestamps
    end

    create_table :answer_votes do |t|
      t.references :answer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :vote, null: false

      t.timestamps
    end
  end
end
