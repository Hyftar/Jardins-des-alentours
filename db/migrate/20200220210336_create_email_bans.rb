class CreateEmailBans < ActiveRecord::Migration[6.0]
  def change
    create_table :email_bans do |t|
      t.string :email, null: false
      t.datetime :banned_until, null: false
      t.text :reason 
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
