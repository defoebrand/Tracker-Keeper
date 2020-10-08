module TracktionsHelper
  def group?(track)
    if track.groups.first
      create_group_link(track)
    else
      @content = content_tag(:a, 'Assign', href: edit_tracktion_path(track))
    end
    @content
  end

  def create_group_link(track)
    @content = content_tag(:p, content_tag(:a, track.groups.first.icon.html_safe,
                                           href: group_path(track.groups.first.id)))
    @content << content_tag(:p, track.groups.first.name)
  end

  def nav_buttons
    if @tracktion.groups.first
      content_tag(:a, '<i class="fas fa-arrow-left"></i>'.html_safe, href: assigned_path)
    else
      content_tag(:a, '<i class="fas fa-arrow-left"></i>'.html_safe, href: unassigned_path)
    end
  end

  def create_additional_group_links(group)
    @content = content_tag(:p, content_tag(:a, group.icon.html_safe,
                                           href: group_path(group.id)))
    @content << content_tag(:p, group.name)
  end

  def additional_groups(group)
    return if group == @tracktion.groups.first

    @nested_content = create_additional_group_links(group)
    @content = content_tag(:div, @nested_content, class: 'container')
  end

  def checked_box?(*args)
    args.each do |arg|
      @content = if @tracktion.groups.select { |group| group if group.name == arg.value }.empty?
                   arg.check_box
                 else
                   arg.check_box(checked: true)
                 end
    end
    @content
  end
end
