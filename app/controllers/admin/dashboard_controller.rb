class Admin::DashboardController < ApplicationController
  layout 'admin'
  def index
    authorize :dashboard, :index?
    @drones_count = Drone.count
    @pilots_count = User.where("roles @> ARRAY[?]::varchar[]", "pilote").count rescue User.count
    @voles_count = Vole.count
    @observations_count = Observation.count
    @voles_per_month = Vole.group_by_month(:created_at, format: "%b %Y").count
  end
end
