class SpecimensController < ApplicationController
  after_action :verify_authorized

  before_action :load_patient
  before_action :load_specimen, only: [:edit, :update]
  before_action :load_form_values, only: [:new, :edit]

  def new
    @specimen = Specimen.new
    authorize @specimen
  end

  def create
    @specimen = Specimen.new(create_params)
    authorize @specimen
    if @specimen.save
      save_clinical_history!
      redirect_to @patient
    else
      load_form_values
      render :new
    end
  end

  def edit
  end

  def update
    if @specimen.update_attributes(update_params)
      save_clinical_history!
      flash[:success] = %(Specimen "#{@specimen.pathology_number}" was updated.)
      redirect_to @patient
    else
      load_form_values
      render :edit
    end
  end

  private

  def create_params
    params.require(:specimen)
      .permit(:pathology_number, :description, :diagnosis, :date_submitted,
              :notes, :gross, :stains, :physician_id, :health_facility_id)
      .merge(patient_id: @patient.id)
  end
  alias_method :update_params, :create_params

  def save_clinical_history!
    if description = params['specimen']['clinical_history_description']
      @specimen.clinical_history_description = description
    end
  end

  def existing_values(column)
    values = Specimen.uniq.order(column).pluck(column)
    values = [''] + values unless values.first == ''
    values
  end

  def load_patient
    @patient = Patient.find(params[:patient_id])
  end

  def load_specimen
    @specimen = Specimen.find(params[:id])
    authorize @specimen
  end

  def load_form_values
    @descriptions = existing_values(:description)
    @diagnoses = existing_values(:diagnosis)
    @physicians = Physician.all.map { |p| [p.full_name, p.id] }
    @health_facilities = HealthFacility.all.map { |p| [p.name, p.id] }
  end
end
