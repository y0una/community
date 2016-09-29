helpers do

  def current_user
    # if session has key called id then find that user with id else return nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user
  end
end
