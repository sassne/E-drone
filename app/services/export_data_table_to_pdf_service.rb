class ExportDataTableToPdfService
  TEMPLATE = "pdf_templates/export_table".freeze
  LAYOUT = "export".freeze

  def self.export_voles(voles)
    headers = [ "Drone", "Décollé le", "Durée du vole", "Remarque" ]
    data = voles.map do |vole|
      {
        "Drone" => vole.drone.nom,
        "Décollé le" => I18n.l(vole.date.to_date, format: :long),
        "Durée" => "#{vole.duree_formatee}",
        "Remarque" => vole.remarque
      }
    end
    title = "Liste des vols"
    WickedPdf.new.pdf_from_string(
      ActionController::Base.new.render_to_string(
        template: TEMPLATE,
        layout: LAYOUT,
        locals: {
          title: title,
          headers: headers,
          data: data,
          account_logo_url: nil
        }
      ),
      orientation: "Landscape"
    )
  end

  def self.export_drones(drones)
    headers = [ "Nom", "Modèle", "Numéro de série", "Total vols" ]
    data = drones.map do |drone|
      {
        "Nom" => drone.nom,
        "Modèle" => drone.modele,
        "Numéro de série" => drone.numero_de_serie,
        "Total vols" => drone.voles.count
      }
    end
    title = "Liste des drones"
    WickedPdf.new.pdf_from_string(
      ActionController::Base.new.render_to_string(
        template: TEMPLATE,
        layout: LAYOUT,
        locals: {
          title: title,
          headers: headers,
          data: data,
          account_logo_url: nil
        }
      ),
      orientation: "Landscape"
    )
  end

  def self.export_observations(observations)
    headers = [ "Vol", "Drone", "Remarque", "Date" ]
    data = observations.map do |obs|
      {
        "Vol" => obs.vole&.id,
        "Drone" => obs.vole.drone.nom,
        "Remarque" => obs.remarque,
        "Date" => obs.observed_at
      }
    end
    title = "Liste des observations"
    WickedPdf.new.pdf_from_string(
      ActionController::Base.new.render_to_string(
        template: TEMPLATE,
        layout: LAYOUT,
        locals: {
          title: title,
          headers: headers,
          data: data,
          account_logo_url: nil
        }
      ),
      orientation: "Landscape"
    )
  end

  def self.export_observations_pdf(vole)
     headers = [ "Heure", "Type", "Borne",  "Remarque" ]
    data = vole.observations.map do |obs|
      {
        "Heure" => I18n.l(obs.observed_at, format: :time),
        "Type" => obs.observation_type,
        "Borne" => obs.borne,
        "Remarque" => obs.remarque
      }
    end
    title = "Observations du vol ##{vole.id}"
    WickedPdf.new.pdf_from_string(
      ActionController::Base.new.render_to_string(
        template: TEMPLATE,
        layout: LAYOUT,
        locals: {
          title: title,
          headers: headers,
          data: data,
          account_logo_url: nil
        }
      ),
      orientation: "Landscape"
    )
  end
end
