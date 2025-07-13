class DronesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_drone, only: [ :show, :edit, :update, :destroy ]

  def index
    @drones = Drone.all.includes(:voles)
  end

  def show
    @drones = Drone.all
    @voles = @drone.voles.recent_first
  end

  def new
    @drone = Drone.new
  end

  def edit
  end

  def create
    @drone = Drone.new(drone_params)

    if @drone.save
      redirect_to @drone, notice: "Drone créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @drone.update(drone_params)
      redirect_to @drone, notice: "Drone mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @drone.destroy
    redirect_to drones_url, notice: "Drone supprimé avec succès."
  end

  private

  def set_drone
    @drone = Drone.find(params[:id])
  end

  def drone_params
    params.require(:drone).permit(:nom, :modele, :numero_de_serie)
  end
end
