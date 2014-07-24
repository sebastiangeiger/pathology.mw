class PatientsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @patient.save
      patient_link = view_context.link_to(@patient.full_name, patient_path(@patient))
      flash[:success] = {html_safe: "Patient #{patient_link} has been created."}
      redirect_to patients_path
    else
      render :new
    end
  end

  private
  def create_params
    params.require(:patient)
      .permit(:first_name, :last_name, :district, :gender, :birthday)
  end
end