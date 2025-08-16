class Observation < ApplicationRecord
  belongs_to :vole

  validates :borne, presence: true
  validates :observation_type, presence: true
end
