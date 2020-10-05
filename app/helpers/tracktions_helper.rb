module TracktionsHelper
  def transactions_count
    @content = tag(:div, class: 'trans-totals')
    filter_transactions
    @type_sums.each do |x|
      @content << content_tag(:span, "#{x[0]}: #{x[1]}")
      @content << ' | ' unless x[0] == @type_sums.keys.last
    end
    @content
  end

  def filter_transactions
    @type_sums = {}
    @tracktions.each do |x|
      @type_sums[x.type.amount_type] = 0
    end

    @tracktions.each do |x|
      @type_sums[x.type.amount_type] += x.amount
    end
    @type_sums
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
                  content_tag(:a, transaction.groups.first.icon.html_safe, href: "/groups/#{transaction.groups.first.id}")
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
