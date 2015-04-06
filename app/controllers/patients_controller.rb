class PatientsController < ApplicationController
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index
  before_action :load_patient, only: [:show, :edit, :update]

  def new
    @patient = Patient.new
    authorize @patient
  end

  def index
    @menu_point_active = :patient
    @patients = policy_scope(Patient)

    @search = Search.new(params[:search])
    if @search.is_executable?
      @patients = @patients.merge(@search.execute)
      @result_size = @patients.count(:all)
    end
    @patients = order_and_paginate(@patients)
    authorize @patients
  end

  def create
    @patient = Patient.new(create_params)
    authorize @patient
    if @patient.save
      flash[:success] = %(Patient "#{@patient.full_name}" has been created.)
      redirect_to @patient
    else
      render :new
    end
  end

  def show
    @activity_feed_items = ActivityFeed.new(@patient.specimens).calculate
  end

  def edit
  end

  def update
    if @patient.update_attributes(update_params)
      flash[:success] = %(Patient "#{@patient.full_name}" was updated.)
      redirect_to @patient
    else
      render :edit
    end
  end

  private

  def order_and_paginate(scope)
    scope.order('id asc').page(params[:page])
  end

  def load_patient
    @patient = Patient.find(params[:id])
    authorize @patient
  end

  def create_params
    params.require(:patient)
      .permit(:first_name, :last_name, :district, :gender, :birthday, :birthyear, :birthday_unknown)
  end
  alias_method :update_params, :create_params
end
