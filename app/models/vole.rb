class Vole < ApplicationRecord
  belongs_to :drone

  validates :date, presence: true
  validates :duree, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Scope pour obtenir les vols triés par date décroissante
  scope :recent_first, -> { order(date: :desc) }
end
