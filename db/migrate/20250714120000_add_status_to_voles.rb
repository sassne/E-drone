class AddStatusToVoles < ActiveRecord::Migration[7.0]
  def change
    add_column :voles, :status, :integer, default: 0, null: false
  end
end
