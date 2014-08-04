class PatientsController < ApplicationController
  load_and_authorize_resource

  def index
    @menu_point_active = :patient
  end

  def new
  end

  def create
    if @patient.save
      flash[:success] = %Q{Patient "#{@patient.full_name}" has been created.}
      redirect_to @patient
    else
      render :new
    end
  end

  def show
    @activity_feed_items = ActivityFeed.new(@patient.specimens).calculate
  end

  private
  def create_params
    params.require(:patient)
      .permit(:first_name, :last_name, :district, :gender, :birthday, :birthyear, :birthday_unknown)
  end
end
