class HomeController < ApplicationController
  def index
    if policy(Patient).index?
      redirect_to patients_path
    end
  end
end
