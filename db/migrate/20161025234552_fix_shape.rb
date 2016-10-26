class FixShape < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :shape_id
    rename_table :shapes, :points
  end
end
