namespace :v5s do

	desc "Reset all Following relations"
	task unfollow_all: :environment do
		puts '=== Unfollowing all ==='
		User.all.each do |u|
			if u.followed_user
				u.unfollow! u.followed_user
				puts "#{u.name} unfollows"
			end
		end
		puts '===       Done      ==='
	end
end