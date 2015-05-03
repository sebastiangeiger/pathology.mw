class HealthFacilitiesController < ApplicationController
  after_action :verify_authorized

  def new
    @health_facility = HealthFacility.new
    authorize @health_facility
  end
end
