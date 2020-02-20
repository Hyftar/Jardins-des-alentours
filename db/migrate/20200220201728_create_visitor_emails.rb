class CreateVisitorEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :visitor_emails do |t|
      t.string :email, null: false
      t.references :visitor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
