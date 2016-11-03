class StaticPagesController < ApplicationController
	def home
		if current_user
			@desire = current_user.desires.build
			# @feed_items = current_user.feed.paginate(page: params[:page])
			@feed_items = Desire.all.select{ |d| d.modified_after_last_xmas? }.take(10)
		end
	end

	def help
	end

	def about
	end

	def letsencrypt
	  render_text: 'Z5RpCSakXqrXbWjZdK622k83XgB7ZHfpu1g5qUEpwjU.VNHdsXHaP7fUlS5_JFvAAu0TMK2KMX0hhx9c2sbxPwQ'
	end
end
