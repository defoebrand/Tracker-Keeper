module TracktionsHelper
  def transactions_count
    @type_id = 0
    @content = tag(:div, class: 'trans-totals')
    filter_transactions
    @type_sums.each_with_index do |x, y|
      # @content << link_to((x[0]).to_s, new_type_path)
      # @content << link_to("#{x[0]} :", type_path)
      # @content << content_tag(:span, (x[1]).to_s)

      ### THIS SHOULD BE SENDING THE AMOUNT_TYPE NAME INTO THE TYPE_PATH

      @type_id = x[1].to_i if y.even?
      @content << content_tag(:p, (@type_id if y.even?))
      @content << link_to((x[0]).to_s, type_path(@type_id.to_i)) if y.odd?
      # @content << content_tag(:span, (x[1]).to_s)
      @content << content_tag(:span, (x[1]).to_s) if y.odd?
      # @content << content_tag(:span)

      # @content << content_tag(:span, (x[2]).to_s)
      # @content << content_tag(:span, y[2].to_s)
      @content << ' | ' unless x[0] == @type_sums.keys.last
    end
    @content
  end

  def filter_transactions
    @type_sums = {}
    @tracktions.each do |x|
      @type_sums["#{x.type.amount_type}_id"] = x.id
      @type_sums[x.type.amount_type] = 0
    end
    # byebug

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
