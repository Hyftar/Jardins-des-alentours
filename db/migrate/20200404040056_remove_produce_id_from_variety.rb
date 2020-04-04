class RemoveProduceIdFromVariety < ActiveRecord::Migration[6.0]
  def change
    remove_column :varieties, :produce_id
  end
end
