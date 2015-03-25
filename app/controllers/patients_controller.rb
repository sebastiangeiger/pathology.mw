class PatientsController < ApplicationController
  before_filter :load_by_pagination, only: :index
  def load_by_pagination
    @patients = Patient.accessible_by(current_ability).order("id asc").page params[:page]
  end
  load_and_authorize_resource

  def index
    @menu_point_active = :patient
    @search = Search.new(params[:search])
    if @search.is_executable?
      results = @search.execute.accessible_by(current_ability)
      @patients = results.page params[:page]
      @result_size = results.count(:all)
    end
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
