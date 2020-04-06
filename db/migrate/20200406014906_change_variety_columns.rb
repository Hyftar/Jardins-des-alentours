class ChangeVarietyColumns < ActiveRecord::Migration[6.0]
  def change
    change_column :varieties, :height, :integer
    change_column :varieties, :spacing, :integer
  end
end
