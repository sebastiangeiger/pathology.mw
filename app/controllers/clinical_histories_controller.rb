class ClinicalHistoriesController < ApplicationController
  after_action :verify_authorized

  load_and_authorize_resource :patient
  load_and_authorize_resource :clinical_history, through: :patient

  def new
  end

  def create
    if @clinical_history.save
      redirect_to @patient
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:clinical_history)
      .permit(:description, :date)
  end
end
