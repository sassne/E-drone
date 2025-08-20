class ObservationDecorator < Draper::Decorator
  delegate_all

  def pilote_name
    object.vole.pilots&.name.presence || object.user&.email
  end

  def vole_id
    object.vole&.id
  end

  def remarque_short
    object.remarque&.truncate(40)
  end
end
