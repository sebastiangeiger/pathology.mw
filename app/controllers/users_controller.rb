class UsersController < ApplicationController
  skip_authorization_check #cancancan

  def index
    @users = User.all
    authorize @users
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
