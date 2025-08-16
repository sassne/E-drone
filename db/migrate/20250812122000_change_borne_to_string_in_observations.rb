class ChangeBorneToStringInObservations < ActiveRecord::Migration[7.0]
  def change
    change_column :observations, :borne, :string
  end
end
