class HealthFacilitiesController < ApplicationController
  after_action :verify_authorized

  def new
    @health_facility = HealthFacility.new
    authorize @health_facility
  end

  def create
    @health_facility = HealthFacility.new(create_params)
    authorize @health_facility
    if @health_facility.save
      flash[:success] = %(Health Facility "#{@health_facility.name}" has been created.)
      redirect_to patients_path
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:health_facility).permit(:name, :postal_address, :telephone,
                                            :district)
  end
end
