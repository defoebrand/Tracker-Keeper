module ApplicationHelper
  def profile_pic(user)
    if user.avatar.attached?
      (image_tag user.avatar, class: 'profile-pic')
    else
      (image_tag '/star.png', class: 'profile-pic')
    end
  end

  def set_type_id(type, _index)
    @nested_content = content_tag(:a, (type[0]).to_s, href: type_path(@type_id))
    @nested_content << content_tag(:p, (type[1]).to_s)
  end
end
