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
