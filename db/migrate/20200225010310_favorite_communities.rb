class FavoriteCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities_users do |t|
      t.references :user, foreign_key: true
      t.references :community, foreign_key: true
    end
  end
end
