require_relative 'admin_policy_helper'
class DashboardPolicy < ApplicationPolicy
  include AdminPolicyHelper
  def index?; admin_or_super_admin?; end
end
