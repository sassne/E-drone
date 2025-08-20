module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(params)
      results = self.where(nil)
      if params[:start_date].present?
        results = results.where("created_at >= ?", params[:start_date])
      end
      if params[:end_date].present?
        results = results.where("created_at <= ?", params[:end_date])
      end
      if params[:drone_name].present? && self.reflect_on_association(:drone)
        results = results.joins(:drone).merge(Drone.search_by_name(params[:drone_name]))
      end
      results
    end
  end
end
