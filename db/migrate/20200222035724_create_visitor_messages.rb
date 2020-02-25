class CreateVisitorMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :visitor_messages do |t|
      t.references :source_visitor_email, index: true, null: false, foreign_key: {to_table: :visitor_emails}
      t.references :recipient_user, index: true, null: false, foreign_key: {to_table: :users}
      t.text :content, presence: true

      t.timestamps
    end
  end
end
