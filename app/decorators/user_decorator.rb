class UserDecorator < Draper::Decorator
  delegate_all

  def display_name
    object.name.presence || object.email
  end

  def roles_badge
    object.roles.map { |role| "<span class='inline-block px-2 py-1 bg-gray-200 rounded text-xs mr-1'>#{role}</span>" }.join.html_safe
  end
end
