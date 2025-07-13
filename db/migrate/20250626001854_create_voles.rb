class CreateVoles < ActiveRecord::Migration[8.0]
  def change
    create_table :voles do |t|
      t.references :drone, null: false, foreign_key: true
      t.datetime :date
      t.integer :duree
      t.text :remarque

      t.timestamps
    end
  end
end
