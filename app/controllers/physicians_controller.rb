class PhysiciansController < ApplicationController
  after_action :verify_authorized

  def new
    @physician = Physician.new
    authorize @physician
  end

  def create
    @physician = Physician.new(create_params)
    authorize @physician
    if @physician.save
      flash[:success] = %(Physician "#{@physician.full_name}" has been created.)
      redirect_to patients_path
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:physician).permit(:first_name, :last_name, :title)
  end
end
