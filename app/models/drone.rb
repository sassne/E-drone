class Drone < ApplicationRecord
  has_many :voles, dependent: :destroy

  validates :nom, presence: true
  validates :modele, presence: true
  validates :numero_de_serie, presence: true, uniqueness: true
end
