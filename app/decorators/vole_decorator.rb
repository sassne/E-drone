class VoleDecorator < Draper::Decorator
  delegate_all

  def pilotes_details
    h.render_details(
      title: "Pilotes",
      data: object.pilots.map { |u| u.name.presence || u.email }.join(", ")
    )
  end

  def remarque_details
    h.render_details(
      title: "Remarque",
      data: object.remarque
    )
  end
end
