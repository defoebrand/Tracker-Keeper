module TracktionsHelper
  def filter_transactions
    @type_sums = {}
    @tracktions.each do |x|
      @type_sums["#{x.type.amount_type}_id"] = x.type.id
      @type_sums[x.type.amount_type] = 0
    end

    @tracktions.each do |x|
      @type_sums[x.type.amount_type] += x.amount
    end
    @type_sums
  end

  def transactions_count
    filter_transactions
    @content = tag(:br)
    @type_sums.each_with_index do |type, index|
      if index.even?
        @type_id = type[1]
      else
        @more_content = content_tag(:div, set_type_id(type, index))
        @content << @more_content
      end
    end
    content_tag(:div, @content, class: 'trans-totals')
  end

  def set_type_id(type, _index)
    @nested_content = content_tag(:a, (type[0]).to_s, href: type_path(@type_id))
    @nested_content << content_tag(:p, (type[1]).to_s)
  end

  def icon?(transaction)
    @content = tag(:p)
    if transaction.groups
      unless transaction.groups.first.nil?
        @content << content_tag(:a, transaction.groups.first.icon.html_safe, href: "/groups/#{transaction.groups}")
      end
    end
    @content
  end

  def group?(transaction)
    @content = tag(:td)
    @content << if !transaction.groups.first.nil?
                  content_tag(:a, transaction.groups.first.icon.html_safe,
                              href: "/groups/#{transaction.groups.first.id}")
                else
                  content_tag(:a, 'Assign', href: "/tracktions/#{transaction.id}/edit")
                end
    @content
  end

  def back(transaction)
    @content = if transaction.groups
                 content_tag(:a, 'Back', href: '/assigned')
               else
                 content_tag(:a, 'Back', href: '/unassigned')
               end
    @content
  end
end
