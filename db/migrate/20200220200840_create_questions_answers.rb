class CreateQuestionsAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.integer :score, null: false, default: 0
      t.references :community, null: false, foreign_key: true
      t.references :selected_answer
      t.timestamps
    end

    create_table :answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :score, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    create_table :questions_varieties do |t|
      t.belongs_to :question
      t.belongs_to :variety
    end

    create_table :tags do |t|
      t.string :name, null: false
      t.integer :score, null: false, default: 0
    end

    create_table :questions_tags do |t|
      t.belongs_to :question
      t.belongs_to :tag
    end
  end
end
