class UsersRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles_users do |t|
      t.references :role, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
