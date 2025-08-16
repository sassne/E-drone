class CreatePilotsVoles < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots_voles do |t|
      t.references :vole, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :pilots_voles, [ :vole_id, :user_id ], unique: true
  end
end
