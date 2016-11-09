class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column 'buildings', 'lan', 'lat'
  end
end
