module ApplicationHelper
  def profile_pic(user)
    if user.avatar.attached?
      (image_tag user.avatar, class: 'profile-pic')
    else
      (image_tag '/star.png', class: 'profile-pic')
    end
  end

  def filter_transactions(filter_type)
    @type_sums = {}
    filter_type.each do |x|
      @type_sums["#{x.type.amount_type}_id"] = x.type.id
      @type_sums[x.type.amount_type] = 0
    end

    filter_type.each do |x|
      @type_sums[x.type.amount_type] += x.amount
    end
    @type_sums
  end

  def transactions_count(filter_type)
    filter_transactions(filter_type)
    @content = tag(:br)
    @type_sums.each_with_index do |type, index|
      index.even? ? @type_id = type[1] : @more_content = content_tag(:div, set_type_id(type, index))
      @content << @more_content unless index.even?
    end
    content_tag(:div, @content, class: 'trans-totals')
  end

  def set_type_id(type, _index)
    @nested_content = content_tag(:a, (type[0]).to_s, href: type_path(@type_id))
    @nested_content << content_tag(:p, (type[1]).to_s)
  end

  def edit_button(type)
    if type == 'tracktion' && @tracktion.author_id == @user.id
      content_tag(:a, '<i class="fas fa-edit"></i>'.html_safe, href: edit_tracktion_path(@tracktion))
    elsif type == 'group' && session[:user_id] == 1
      content_tag(:a, '<i class="fas fa-edit"></i>'.html_safe, href: edit_group_path(@group))
    end
  end
end
