module UsersHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user, options = { size: 50 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar img-polaroid")
	end

	def avatar_for(user, size)
		if user.avatar?
			# image_tag user.avatar.url size 
			image_tag((image_path user.avatar.url size), alt: user.name, class: "gravatar img-polaroid")
		else
			case size
			when :small
				gravatar_for user, size: 24
			when :thumb
				gravatar_for user, size: 52
			when :medium
				gravatar_for user, size: 150
			end
		end
	end

end
