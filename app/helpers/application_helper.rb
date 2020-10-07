module ApplicationHelper
  def profile_pic(user)
    if user.avatar.attached?
      (image_tag user.avatar, class: 'profile-pic')
    else
      (image_tag '/star.png', class: 'profile-pic')
    end
  end
end
