class SearchesController < ApplicationController
  skip_authorization_check
  #TODO: Needs security
  #TODO: Needs to use the Patient Table with pagination

  def new
    @search = Search.new(params[:search])
    if @search.is_executable?
      @patients = @search.execute
    end
  end
end
