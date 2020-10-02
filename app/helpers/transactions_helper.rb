module TransactionsHelper
  def assigned_transactions_count
    @content = tag(:div, class: 'trans-totals')
    @transactions.each { |x| @assigned_type_sums[x.amount_type] = 0 unless x.group_id.nil? }
    @transactions.each { |x| @assigned_type_sums[x.amount_type] += x.amount unless x.group_id.nil? }
    @assigned_type_sums.each do |x|
      @content << content_tag(:span, "#{x[0]}: #{x[1]}")
      @content << ' | ' unless x[0] == @assigned_type_sums.keys.last
      @content << tag(:br)
    end
    @content
  end

  def unassigned_transactions_count
    @content = tag(:div, class: 'trans-totals')
    @transactions.each { |x| @unassigned_type_sums[x.amount_type] = 0 if x.group_id.nil? }
    @transactions.each { |x| @unassigned_type_sums[x.amount_type] += x.amount if x.group_id.nil? }
    @unassigned_type_sums.each do |x|
      @content << content_tag(:span, "#{x[0]}: #{x[1]}")
      @content << ' | ' unless x[0] == @unassigned_type_sums.keys.last
    end
    @content
  end

  def icon?(transaction)
    @content = tag(:p)
    if transaction.group_id
      @content << content_tag(:a, transaction.group.icon.html_safe, href: "/groups/#{transaction.group_id}")
    end
    @content
  end

  def group?(transaction)
    @content = tag(:td)
    @content << if transaction.group_id
                  transaction.group.name
                else
                  content_tag(:a, 'Assign', href: "/transactions/#{transaction.id}/edit")
                end
    @content
  end

  def back(transaction)
    # @content = tag(:span)
    @content = if transaction.group_id
                 content_tag(:a, 'Back', href: '/assigned_transactions')
               else
                 content_tag(:a, 'Back', href: '/unassigned_transactions')
               end
    @content
  end
end
