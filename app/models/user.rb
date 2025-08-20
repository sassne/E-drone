class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :voles, join_table: "pilots_voles"

  ROLES = %w[pilote observateur admin super_admin]


  def has_role?(role)
    roles.include?('super_admin') || roles.include?(role.to_s)
  end

  def add_role(role)
    update(roles: (roles + [ role.to_s ]).uniq)
  end

  def remove_role(role)
    update(roles: (roles - [ role.to_s ]))
  end
end
