class ObservationsController < ApplicationController
  before_action :set_vole, only: [:new, :create, :index]
  before_action :set_observation, only: []

  def index
    @observations = @vole ? @vole.observations : Observation.all
  end

  def new
    @observation = @vole ? @vole.observations.build : Observation.new
  end

  def create
    @observation = @vole ? @vole.observations.build(observation_params) : Observation.new(observation_params)
    @observation.observed_at = Time.zone.now
    if @observation.save
      redirect_to vole_observations_path(@vole), notice: "Observation ajoutée."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_vole
    @vole = Vole.find(params[:vole_id]) if params[:vole_id]
  end

  def set_observation
    @observation = Observation.find(params[:id])
  end

  def observation_params
    params.require(:observation).permit(:borne, :observation_type, :remarque)
  end
end
