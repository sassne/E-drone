class VolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vole, only: [ :show, :edit, :update, :destroy ]
  before_action :set_drone, only: [ :new, :create ]

  def index
    @voles = Vole.includes(:drone).recent_first
  end

  def show
  end

  def new
    @vole = @drone ? @drone.voles.build : Vole.new
  end

  def edit
  end

  def create
    @vole = Vole.new(vole_params)

    if @vole.save
      redirect_to @vole.drone, notice: "Vol enregistré avec succès."
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

  private

  def set_vole
    @vole = Vole.find(params[:id])
  end

  def set_drone
    @drone = Drone.find(params[:drone_id]) if params[:drone_id]
  end

  def vole_params
    params.require(:vole).permit(:drone_id, :date, :duree, :remarque)
  end
end
