class AddCommunityToRoles < ActiveRecord::Migration[6.0]
  def change
    add_reference :roles, :community, null: true, foreign_key: true
  end
end
