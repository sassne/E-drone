class Admin::ObservationsController < ApplicationController
  layout "admin"
  before_action :set_observation, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize Observation
    @observations = Observation.all.recent_first.map(&:decorate)
  end

  def new
    authorize Observation
    @observation = Observation.new
  end

  def create
    authorize Observation
    @observation = Observation.new(observation_params)
    if @observation.save
      redirect_to admin_observations_path, notice: "Observation créée avec succès."
    else
      render :new
    end
  end

  def edit
    authorize @observation
  end

  def update
    authorize @observation
    if @observation.update(observation_params)
      redirect_to admin_observations_path, notice: "Observation mise à jour."
    else
      render :edit
    end
  end

  def destroy
    authorize @observation
    @observation.destroy
    redirect_to admin_observations_path, notice: "Observation supprimée."
  end

  # Export all observations as Excel
  def export_excel
    authorize Observation
    @observations = Observation.all
    respond_to do |format|
      format.xlsx {
        response.headers["Content-Disposition"] = 'attachment; filename="observations.xlsx"'
      }
    end
  end

  # Export all observations as PDF
  def export_pdf
    authorize Observation
    @observations = Observation.all
    pdf = ExportDataTableToPdfService.export_observations(@observations)
    send_data pdf, filename: "observations.pdf", type: "application/pdf", disposition: "attachment"
  end

  private
    def set_observation
      @observation = Observation.find(params[:id])
    end

    def observation_params
      params.require(:observation).permit(:vole_id, :content, :user_id)
    end
end
