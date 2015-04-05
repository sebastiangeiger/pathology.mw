class PhysiciansController < ApplicationController
  load_and_authorize_resource

  def create
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
