class UsersController < ApplicationController
  def index
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    user.update_attributes(params[:user].permit(:role_name))
    if user.save
      redirect_to action: :index
    else
      render action: :edit
    end
  end
end
