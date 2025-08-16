class Vole < ApplicationRecord
  belongs_to :drone
  has_many :observations, dependent: :destroy
    validates :date, presence: true

  has_and_belongs_to_many :pilots, class_name: "User", join_table: "pilots_voles"

  # Scope pour obtenir les vols triés par date décroissante
  scope :recent_first, -> { order(date: :desc) }

  # app/models/vole.rb
  def duree_formatee
    return "-" unless duree.present? && duree > 0

    heures = duree / 60
    minutes = duree % 60

    if heures > 0
      "#{heures}h #{minutes}min"
    else
      "#{minutes}min"
    end
  end
end
