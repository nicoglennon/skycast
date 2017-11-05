class UsersController < ApplicationController
  def new
    redirect_to new_weather_path if helpers.current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      helpers.login(@user)
      redirect_to new_weather_path
    else
      #TODO: Error messages customized for displaying to user
      @error = 'ERROR - User did not save'
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
