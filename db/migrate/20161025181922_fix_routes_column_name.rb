class FixRoutesColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :routes, :type, :route_type
  end
end
