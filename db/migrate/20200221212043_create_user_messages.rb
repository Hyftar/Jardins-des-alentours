class CreateUserMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_messages do |t|
      t.references :source_user, index: true, null: false, foreign_key: {to_table: :users}
      t.references :recipient_user, index: true, null: false, foreign_key: {to_table: :users}
      t.text :content, presence: true

      t.timestamps
    end
  end
end
