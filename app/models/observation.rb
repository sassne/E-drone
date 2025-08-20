class Observation < ApplicationRecord
  belongs_to :vole

  validates :borne, presence: true
  validates :observation_type, presence: true

  # Scope pour trier les observations par date de création décroissante
  scope :recent_first, -> { order(created_at: :desc) }
end
