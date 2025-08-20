
class Drone < ApplicationRecord
  include PgSearch::Model
  include Filterable
  has_many :voles, dependent: :destroy

  pg_search_scope :search_by_name, against: :nom, using: { tsearch: { prefix: true } }

  validates :nom, presence: true
  validates :modele, presence: true
  validates :numero_de_serie, presence: true, uniqueness: true
end
