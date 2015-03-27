class SpecimensController < ApplicationController
  load_and_authorize_resource :patient
  load_and_authorize_resource :specimen, through: :patient

  def new
    @descriptions = existing_values(:description)
    @diagnoses = existing_values(:diagnosis)
    @specimen.pathology_number ||= "#{Time.zone.today.year}-QT-"
  end

  def create
    if @specimen.save
      save_clinical_history!
      redirect_to @patient
    else
      render :new
    end
  end

  def edit
    @descriptions = existing_values(:description)
    @diagnoses = existing_values(:diagnosis)
    @specimen.pathology_number ||= "#{Time.zone.today.year}-QT-"
  end

  def create_params
    params.require(:specimen)
      .permit(:pathology_number, :description, :diagnosis, :date_submitted, :notes,
              :gross, :stains)
  end

  def save_clinical_history!
    if description = params['specimen']['clinical_history_description']
      @specimen.clinical_history_description = description
    end
  end

  private
  def existing_values(column)
    values = Specimen.uniq.order(column).pluck(column)
    values = [""] + values unless values.first == ""
    values
  end
end
