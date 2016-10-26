class AddShapeIdTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :shape_id, :integer
  end
end
