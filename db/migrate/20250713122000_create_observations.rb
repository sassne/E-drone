class CreateObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :observations do |t|
      t.references :vole, null: false, foreign_key: true
      t.integer :borne, null: false
      t.string :observation_type, null: false
      t.text :remarque
      t.datetime :observed_at, null: false
      t.timestamps
    end
  end
end
