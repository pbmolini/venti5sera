class PasswordResetsController < ApplicationController
	# Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      # @user.deliver_password_reset_instructions!
      @user.reset_perishable_token!
      UserMailer.password_reset_instructions(@user).deliver
      flash[:notice] = t('flash.password_reset_instructions')
      redirect_to root_path
    else
      flash.now[:error] = t("flash.no_user_with_email", email: params[:email])
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.password = params[:password]
    # Only if your are using password confirmation
    @user.password_confirmation = params[:password_confirmation]

    # Use @user.save_without_session_maintenance instead if you
    # don't want the user to be signed in automatically.
    if @user.save
      flash[:success] = t('flash.password_updated')
      redirect_to @user
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id]) # this in not the user_id 
    # it is the reset_perishable_token in the url like /password_resets/kgdaskjhdgj87/edit
    unless @user
      flash[:error] = t('flash.cannot_locate_account')
      redirect_to root_url
    end
  end
end
