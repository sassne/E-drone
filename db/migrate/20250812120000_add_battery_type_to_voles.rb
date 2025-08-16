class AddBatteryTypeToVoles < ActiveRecord::Migration[7.0]
  def change
    add_column :voles, :battery_type, :string
  end
end
