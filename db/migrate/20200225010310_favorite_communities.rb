class FavoriteCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_communities do |t|
      t.references :users, foreign_key: true
      t.references :communities, foreign_key: true
    end
  end
end
