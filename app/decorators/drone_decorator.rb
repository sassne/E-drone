class DroneDecorator < Draper::Decorator
  delegate_all

  def nom_modele
    "#{object.nom} (#{object.modele})"
  end

  def numero_de_serie
    object.serial_number || object.numero_de_serie
  end

  def vols_count
    object.voles.count
  end
end
