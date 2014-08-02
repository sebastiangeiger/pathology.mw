class SpecimensController < ApplicationController
  load_and_authorize_resource :patient
  load_and_authorize_resource :specimen, through: :patient

  def new
  end

  def create
    if @specimen.save
      save_clinical_history!
      redirect_to @patient
    else
      render :new
    end
  end

  def create_params
    params.require(:specimen)
      .permit(:pathologist, :description, :diagnosis, :date_submitted, :notes,
              :gross, :stains)
  end

  def save_clinical_history!
    if description = params['specimen']['clinical_history_description']
      @specimen.clinical_history_description = description
    end
  end
end
