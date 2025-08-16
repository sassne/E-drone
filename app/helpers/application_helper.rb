  def render_details(title:, data:)
    if data.nil?
      "-"
    else
      render "shared/details", title: title, data: data
    end
  end
module ApplicationHelper
  def active_class(path)
    current_page?(path) ? "active" : ""
  end
end
