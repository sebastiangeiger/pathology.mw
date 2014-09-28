class SearchesController < ApplicationController
  skip_authorization_check
  # before_filter do
  #   authorize! if can? :create, :search
  # end

  def new
    @search = Search.new(params[:search])
    if @search.is_executable?
      @results = @search.execute
      render :show
    end
  end
end
