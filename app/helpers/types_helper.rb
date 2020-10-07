module TypesHelper
  def filter_type_transactions
    @type.tracktions.each do |x|
      @type_sums["#{x.type.amount_type}_id"] = x.type.id
      @type_sums[x.type.amount_type] = 0
    end

    @type.tracktions.each do |x|
      @type_sums[x.type.amount_type] += x.amount
    end
    @type_sums
  end

  def type_transactions_count
    filter_type_transactions
    @content = tag(:br)
    @type_sums.each_with_index do |type, index|
      index.even? ? (@type_id = type[1]) : @more_content = content_tag(:div, set_type_id(type, index))
      @content << @more_content unless index.even?
    end
    content_tag(:div, @content, class: 'trans-totals')
  end

  def set_type_id(type, _index)
    @nested_content = content_tag(:a, (type[0]).to_s, href: type_path(@type_id))
    @nested_content << content_tag(:p, (type[1]).to_s)
  end
end
