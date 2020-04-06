class RemoveHabtmUsersCommunities < ActiveRecord::Migration[6.0]
  def change
    drop_table :communities_users
  end
end
