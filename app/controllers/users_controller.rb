class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    @user.update_attributes(params[:user].permit(:role_name))
    if @user.save
      redirect_to action: :index
    else
      render action: :edit
    end
  end
end
