class StaticPagesController < ApplicationController
	def home
		if current_user
			@desire = current_user.desires.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def help
	end

	def about
	end
end
