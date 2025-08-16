class VolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vole, only: [ :show, :edit, :update, :destroy, :land, :add_observation, :export_pdf, :export_excel, :export_observations_pdf ]
  before_action :set_drone, only: [ :new, :create ]

  def index
    @voles = Vole.includes(:drone).recent_first.map(&:decorate)
  end

  def show
    @vole = @vole.decorate
  end

  def new
    @vole = @drone ? @drone.voles.build : Vole.new
  end

  def edit
  end

  def create
    @vole = Vole.new(vole_params)

    if @vole.save
      redirect_to @vole, notice: "Vol enregistré avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @vole.update(vole_params)
      redirect_to @vole.drone, notice: "Vol mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    drone = @vole.drone
    @vole.destroy
    redirect_to drone, notice: "Vol supprimé avec succès."
  end

  def land
    if @vole.land_at.nil?
      @vole.land_at = Time.zone.now
      @vole.duree = ((@vole.land_at - @vole.created_at) / 60).to_i
      @vole.save
      flash[:notice] = "Atterrissage enregistré."
    end
    redirect_to @vole
  end

  def add_observation
    @observation = @vole.observations.build(observation_params)
    @observation.observed_at = Time.zone.now
    if @observation.save
      flash[:notice] = "Observation ajoutée."
    else
      flash[:alert] = @observation.errors.full_messages.join(", ")
    end
    redirect_to @vole
  end

  def export_pdf
    pdf = ExportDataTableToPdfService.export_voles(Vole.includes(:drone).recent_first)
    send_data pdf, filename: "vols.pdf", type: "application/pdf"
  end

  def export_excel
    package = Axlsx::Package.new
    workbook = package.workbook
    workbook.add_worksheet(name: "Vol") do |sheet|
      sheet.add_row [ "Borne", "Type", "Remarque", "Heure" ]
      @vole.observations.each do |obs|
        sheet.add_row [ obs.borne, obs.observation_type, obs.remarque, obs.observed_at.strftime("%H:%M") ]
      end
    end
    send_data package.to_stream.read, filename: "vol_#{@vole.id}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end

  def export_observations_pdf
    pdf = ExportDataTableToPdfService.export_observations_pdf(@vole)
    send_data pdf, filename: "observations_vole_#{@vole.id}.pdf", type: "application/pdf"
  end

  private

  def set_vole
    @vole = Vole.find(params[:id])
  end

  def set_drone
    @drone = Drone.find(params[:drone_id]) if params[:drone_id]
  end

  def vole_params
    params.require(:vole).permit(:drone_id, :date, :duree, :remarque, :battery_type, pilot_ids: [])
  end

  def observation_params
    params.require(:observation).permit(:borne, :observation_type, :remarque)
  end
end
