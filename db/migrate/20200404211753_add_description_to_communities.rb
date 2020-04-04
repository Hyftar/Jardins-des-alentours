class AddDescriptionToCommunities < ActiveRecord::Migration[6.0]
  def change
    add_column :communities, :description, :string
  end
end
