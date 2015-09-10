module UsersHelper

  # Return the Gravatar (http://gravatar.com) for a given user
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"

    # method correct_chef? is used to select the right image
    if correct_chef?(user)
    image_tag("chef.png", alt: user.name, class: "gravatar")
    else
    image_tag("taster.png", alt: user.name, class: "gravatar")

    end
  end

end
