class SpecimensController < ApplicationController
  load_and_authorize_resource :patient
  load_and_authorize_resource :specimen, through: :patient

  def new
  end

  def create
    if @specimen.save
      redirect_to @patient
    else
      render :new
    end
  end

  def create_params
    params.require(:specimen)
      .permit(:pathologist, :description, :diagnosis, :date_submitted, :notes)
  end
end
