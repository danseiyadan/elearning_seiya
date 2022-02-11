module UsersHelper
  def gravatar_for(user, options = { size: 50}) # カッコ内の書き方に合わせてビューを記載する。
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")        
  end
  # gravatarを呼び出すためのメソッド。
end
