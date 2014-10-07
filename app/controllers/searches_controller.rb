class SearchesController < ApplicationController
  load_and_authorize_resource

  def new
    @search = Search.new(params[:search])
    if @search.is_executable?
      results = @search.execute.accessible_by(current_ability)
      @patients = results.page params[:page]
      @result_size = results.count(:all)
    end
  end
end
