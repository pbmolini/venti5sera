class RelationshipsController < ApplicationController
  before_filter :require_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    begin
      UserMailer.start_following(@user).deliver
    rescue Timeout::Error
      flash[:notice] = t('flash.mail_problem')
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    begin
      UserMailer.stop_following(@user).deliver
    rescue Timeout::Error
      flash[:notice] = t('flash.mail_problem')
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
