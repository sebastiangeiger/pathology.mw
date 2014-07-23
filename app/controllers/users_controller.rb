class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user].permit(:role_name))
    if @user.save
      redirect_to action: :index
    else
      render action: :edit
    end
  end
end
