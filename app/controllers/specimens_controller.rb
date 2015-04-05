class SpecimensController < ApplicationController
  load_and_authorize_resource :patient
  load_and_authorize_resource :specimen, through: :patient
  before_filter :load_form_values, only: [:new, :edit]

  def new
  end

  def create
    if @specimen.save
      save_clinical_history!
      save_physician!
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
      flash[:success] = %Q{Specimen "#{@specimen.pathology_number}" was updated.}
      redirect_to @patient
    else
      load_form_values
      render :edit
    end
  end

  private
  def create_params
    params.require(:specimen)
      .permit(:pathology_number, :description, :diagnosis, :date_submitted, :notes,
              :gross, :stains, :physician)
  end
  alias update_params create_params

  def save_clinical_history!
    if description = params['specimen']['clinical_history_description']
      @specimen.clinical_history_description = description
    end
  end

  def save_physician!
    physician_id = params['specimen']['physician_id']
    if physician_id.present?
      @specimen.physician = Physician.find(physician_id)
      @specimen.save
    end
  end

  def existing_values(column)
    values = Specimen.uniq.order(column).pluck(column)
    values = [""] + values unless values.first == ""
    values
  end

  def load_form_values
    @descriptions = existing_values(:description)
    @diagnoses = existing_values(:diagnosis)
    @physicians = Physician.all
  end
end
