class StaticPagesController < ApplicationController
	def home
		if current_user
			@desire = current_user.desires.build
			# @feed_items = current_user.feed.paginate(page: params[:page])
			@feed_items = Desire.all(limit: 10)
		end
	end

	def help
	end

	def about
	end
end
