class Admin::VolesController < ApplicationController
  layout "admin"
  before_action :set_vole, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize Vole
    @voles = Vole.all.recent_first.map(&:decorate)
  end

  def new
    authorize Vole
    @vole = Vole.new
  end

  def create
    authorize Vole
    @vole = Vole.new(vole_params)
    if @vole.save
      redirect_to admin_voles_path, notice: "Vol créé avec succès."
    else
      render :new
    end
  end

  def edit
    authorize @vole
  end

  def update
    authorize @vole
    if @vole.update(vole_params)
      redirect_to admin_voles_path, notice: "Vol mis à jour."
    else
      render :edit
    end
  end

  def destroy
    authorize @vole
    @vole.destroy
    redirect_to admin_voles_path, notice: "Vol supprimé."
  end

  # Export all voles as Excel
  def export_excel
    authorize Vole
    @voles = Vole.all
    respond_to do |format|
      format.xlsx {
        response.headers["Content-Disposition"] = 'attachment; filename="vols.xlsx"'
      }
    end
  end

  # Export all voles as PDF
  def export_pdf
    authorize Vole
    @voles = Vole.all
    pdf = ExportDataTableToPdfService.export_voles(@voles)
    send_data pdf, filename: "vols.pdf", type: "application/pdf", disposition: "attachment"
  end

  private
    def set_vole
      @vole = Vole.find(params[:id])
    end

    def vole_params
      params.require(:vole).permit(:drone_id, :battery_type, :date, :duration, :status, user_ids: [])
    end
end
