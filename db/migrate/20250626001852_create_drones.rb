class CreateDrones < ActiveRecord::Migration[8.0]
  def change
    create_table :drones do |t|
      t.string :nom
      t.string :modele
      t.string :numero_de_serie

      t.timestamps
    end
  end
end
