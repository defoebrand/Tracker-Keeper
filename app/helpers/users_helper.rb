module UsersHelper
  def user_images(user)
    user.avatar.attached? ? (image_tag user.avatar.variant(resize_to_limit: [100, 100])) : (image_tag '', size: '100x100', alt: 'No Image', style: 'border:1px solid black')
  end
end
