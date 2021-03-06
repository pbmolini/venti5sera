class ApplicationController < ActionController::Base
  protect_from_forgery
  # filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :current_user?, :max_users_reached?

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
        redirect_to signin_url, notice: t('flash.not_allowed_in')
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        redirect_to current_user, notice: t('flash.not_allowed_out')
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

    def max_users_reached?
      User.all.count >= ENV["MAX_USERS"].to_i
    end
end
