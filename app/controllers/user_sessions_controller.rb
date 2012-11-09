class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    user = User.find_by_email(params[:user_session][:email].downcase)
    if @user_session.save
      flash[:success] = t('flash.login_success')
      redirect_back_or_default root_path
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:success] = t('flash.logout_success')
    redirect_to root_path
  end
end