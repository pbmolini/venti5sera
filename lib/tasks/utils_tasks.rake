namespace :v5s do

	desc "Reset all Following relations"
	task unfollow_all: :environment do
		puts '=== Unfollowing all ==='
		User.all.each do |u|
			u.unfollow! u.followed_user if u.followed_user
		end
	end
end