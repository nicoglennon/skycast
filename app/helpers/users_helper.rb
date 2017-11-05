module UsersHelper
  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    p session
    p session[:user_id]
    User.find(session[:user_id])
  end

  def logout
    session.delete(:user_id)
    current_user = nil
  end
end
