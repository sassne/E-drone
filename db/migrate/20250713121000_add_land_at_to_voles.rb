class AddLandAtToVoles < ActiveRecord::Migration[7.0]
  def change
    add_column :voles, :land_at, :datetime
  end
end
