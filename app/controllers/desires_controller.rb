class DesiresController < ApplicationController
	before_filter :require_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def create
		@desire = current_user.desires.build(params[:desire])
		if @desire.save
			flash[:success] = "Desire created!"
			redirect_to root_url
		else
			redirect_to root_url
		end
	end

	def destroy
		@desire.destroy
		redirect_to root_url
	end

	private

	def correct_user
		@desire = current_user.desires.find_by_id(params[:id])
		redirect_to root_url if @desire.nil?
	end
end