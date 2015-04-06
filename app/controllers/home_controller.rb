class HomeController < ApplicationController
  def index
    if can? :read, Patient
      redirect_to patients_path
    end
  end
end
