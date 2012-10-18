module ApplicationHelper

	# Returns the full title on a per-page basis
	def full_title(page_title)
		base_title = "Venti5sera"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	

  def signed_in?
  	false
  end
end
