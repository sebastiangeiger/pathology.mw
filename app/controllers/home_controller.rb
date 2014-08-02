class HomeController < ApplicationController
  skip_authorization_check
  def index
    if can? :read, Patient
      redirect_to patients_path
    end
  end
end
