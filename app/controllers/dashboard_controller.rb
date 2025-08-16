class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_drones = Drone.count
    @total_vols = Vole.count
    @total_heures_vol = (Vole.sum(:duree) / 60.0).round(1)
    @moyenne_vols_par_drone = @total_drones.zero? ? 0 : (@total_vols.to_f / @total_drones).round(1)

    @recent_vols = Vole.includes(:drone).order(date: :desc).limit(5)
    @drones = Drone.includes(:voles).order(created_at: :desc).limit(5)

     @drone_stats = Drone.all.map do |drone|
        vols = drone.voles
        {
          drone: drone,
          total_vols: vols.count,
          total_heures: vols.sum(:duree) / 60.0
        }
      end
  end
end
