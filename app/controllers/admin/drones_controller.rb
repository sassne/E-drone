class Admin::DronesController < ApplicationController
  layout "admin"
  before_action :set_drone, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize Drone
    @drones = Drone.all
  end

  def new
    authorize Drone
    @drone = Drone.new
  end

  def create
    authorize Drone
    @drone = Drone.new(drone_params)
    if @drone.save
      redirect_to admin_drones_path, notice: "Drone créé avec succès."
    else
      render :new
    end
  end

  def edit
    authorize @drone
  end

  def update
    authorize @drone
    if @drone.update(drone_params)
      redirect_to admin_drones_path, notice: "Drone mis à jour."
    else
      render :edit
    end
  end

  def destroy
    authorize @drone
    @drone.destroy
    redirect_to admin_drones_path, notice: "Drone supprimé."
  end

  # Export all drones as Excel
  def export_excel
    authorize Drone
    @drones = Drone.all
    respond_to do |format|
      format.xlsx {
        response.headers["Content-Disposition"] = 'attachment; filename="drones.xlsx"'
      }
    end
  end

  # Export all drones as PDF
  def export_pdf
    authorize Drone
    @drones = Drone.all
    pdf = ExportDataTableToPdfService.export_drones(@drones)
    send_data pdf, filename: "drones.pdf", type: "application/pdf", disposition: "attachment"
  end

  private
    def set_drone
      @drone = Drone.find(params[:id])
    end

    def drone_params
      params.require(:drone).permit(:serial_number, :model, :battery_type)
    end
end
