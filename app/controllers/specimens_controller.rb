class SpecimensController < ApplicationController
  load_and_authorize_resource :patient
  load_and_authorize_resource :specimen, through: :patient

  def new
  end

end
