# Module pour DRY dans les policies admin
module AdminPolicyHelper
  def admin_or_super_admin?
    user.has_role?(:admin) || user.has_role?(:super_admin)
  end
end
