class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, only: [:edit, :udpate, :destroy]
  before_filter :require_admin, only: :destroy

  def new
  	@user = User.new(category_id: Category.last.id)
    flash[:notice] = t('flash.max_users_reached') if max_users_reached?
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      begin
        UserMailer.registration_confirmation(@user).deliver
        UserMailer.new_user_created(@user).deliver
        flash[:success] = t('flash.registration_success')
      rescue Timeout::Error
        flash[:success] = "#{t('flash.registration_success')} #{t('flash.mail_problem')}"
      end
      redirect_to root_path
    else
      render new_user_path
    end
  end

  def destroy
    # User.find(params[:id]).destroy
    user_to_destroy = User.find(params[:id])
    user_to_destroy.destroy unless user_to_destroy.admin
    flash[:success] = t('flash.user_destroyed')
    redirect_to users_url
  end

  def edit
    @user = current_user.admin ? User.find(params[:id]) : current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = t('flash.profile_updated')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @tot_users = User.all.count
    if current_user && params[:search]
      @users = User.search(params[:search]).paginate(page: params[:page], per_page: 20)
    else
      @users = User.paginate(page: params[:page], per_page: 20)
    end
  end

  def show
    @user = User.find(params[:id])
    @desires = @user.desires.paginate(page: params[:page], per_page: 20)
    @previous_desires = @user.desires - @user.current_desires
  end

  def remove_avatar
    @user = User.find(params[:id])
    # @user.avatar = nil
    if @user.save
      # flash[:success] = t('flash.avatar_removed')
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def require_admin
    redirect_to(root_path) unless current_user.admin?
  end

end
