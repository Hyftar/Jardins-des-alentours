class AddLocationToGardens < ActiveRecord::Migration[6.0]
  def change
    add_reference :gardens, :location, null: false, foreign_key: true
  end
end
