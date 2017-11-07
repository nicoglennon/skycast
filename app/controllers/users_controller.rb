class UsersController < ApplicationController
  def new
    redirect_to '/search' if helpers.logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username = @user.username.downcase

    if @user.save
      helpers.login(@user)
      redirect_to '/search'
    else
      @error = 'This username is taken!'
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id]) || @user = User.find_by(username: params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
