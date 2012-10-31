class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, only: [:edit, :udpate, :destroy]
  before_filter :require_admin, only: :destroy

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      UserMailer.registration_confirmation(@user).deliver
      UserMailer.new_user_created(@user).deliver
  		flash[:success] = "Registration success"
  		redirect_to root_path
  	else
  		render new_user_path
  	end
  end

  def destroy
    # User.find(params[:id]).destroy
    user_to_destroy = User.find(params[:id])
    user_to_destroy.destroy unless user_to_destroy.admin
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # puts params
      # if !params[:user][:avatar]
      #   @user.avatar = nil
      #   @user.save
      # end
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find(params[:id])
    @desires = @user.desires.paginate(page: params[:page], per_page: 20)
  end

  private

    def require_admin
      redirect_to(root_path) unless current_user.admin?
    end

end
