module TypesHelper
  def group_link(track)
    if track.groups.first
      content_links(track)
    else
      @content = content_tag(:p, content_tag(:a, 'Assign', href: edit_tracktion_path(track)))
    end
    @content
  end

  def content_links(track)
    @content = content_tag(:p, content_tag(:a, track.groups.last.icon.html_safe, href: group_path(track.groups.last)))
    @content << content_tag(:p, track.groups.last.name)
  end
end
