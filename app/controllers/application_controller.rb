class ApplicationController < ActionController::Base
  protect_from_forgery
  # filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :current_user?

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

	  def current_user?(user)
	    user == current_user
	  end

    def require_user
      unless current_user
        store_location
        redirect_to signin_url, notice: "You must be logged in to access that page"
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        redirect_to current_user, notice: "You must be logged out to access that page"
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.url
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
