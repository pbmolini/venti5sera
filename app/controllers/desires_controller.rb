class DesiresController < ApplicationController
	before_filter :require_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def create
		@desire = current_user.desires.build(params[:desire])
		if @desire.save
			UserMailer.new_desire(current_user.follower).deliver if current_user.follower
			flash[:success] = t('flash.desire_created')
			redirect_to root_url
		else
			# @feed_items = current_user.feed.paginate(page: params[:page])
			@feed_items = Desire.all(limit: 10)
			render 'static_pages/home'
		end
	end

	def destroy
		@desire.destroy
		UserMailer.removed_desire(current_user.follower).deliver if current_user.follower
		redirect_to root_url
	end

	def edit
		@desire = Desire.find(params[:id])
	end

  def update
    @desire = Desire.find(params[:id])
    if @desire.update_attributes(params[:desire])
			UserMailer.updated_desire(current_user.follower).deliver if current_user.follower
      # Handle a successful update.
      flash[:success] = t('flash.desire_updated')
      redirect_to current_user
    else
      render 'edit'
    end
  end

	private

	def correct_user
		@desire = current_user.desires.find_by_id(params[:id])
		redirect_to root_url if @desire.nil?
	end
end