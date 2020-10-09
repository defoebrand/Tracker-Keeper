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

  def filter_type_transactions(filter_type)
    @type_sums = {}
    filter_type.each do |track|
      if track.groups.first
        loop(track)
      else
        @type_sums['Unassigned_id'] = 0
        @type_sums['Unassigned'] = 0
      end
    end
    fill_in_totals(filter_type)
  end

  def loop(track)
    track.groups.each do |group|
      @type_sums["#{group.name}_id"] = group.id
      @type_sums[group.name] = 0
    end
  end

  def fill_in_totals(filter_type)
    filter_type.each do |track|
      if track.groups.first
        track.groups.each do |group|
          @type_sums[group.name] += track.amount
        end
      else
        @type_sums['Unassigned'] += track.amount
      end
    end
    @type_sums
  end

  def type_transactions_count(filter_type)
    filter_type_transactions(filter_type)
    @content = tag(:br)
    @type_sums.each_with_index do |type, index|
      index.even? ? @group_id = type[1] : @more_content = content_tag(:div, group_id(type))
      @content << @more_content unless index.even?
    end
    content_tag(:div, @content, class: 'trans-totals')
  end

  def group_id(type)
    @nested_content = if type[0] == 'Unassigned'
                        content_tag(:a, (type[0]).to_s, href: unassigned_path)
                      else
                        content_tag(:a, (type[0]).to_s, href: group_path(@group_id))
                      end
    @nested_content << content_tag(:p, (type[1]).to_s)
  end
end
