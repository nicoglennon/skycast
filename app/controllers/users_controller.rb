class UsersController < ApplicationController
  def new
    redirect_to new_search_path if helpers.logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      helpers.login(@user)
      redirect_to new_search_path
    else
      #TODO: Error messages customized for displaying to user
      @error = 'ERROR - User did not save'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
