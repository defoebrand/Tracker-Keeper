module TransactionsHelper
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
    @transactions.each do |x|
      @type_sums[x.amount_type] = 0
    end

    @transactions.each do |x|
      @type_sums[x.amount_type] += x.amount
    end
    @type_sums
  end

  def icon?(transaction)
    @content = tag(:p)
    if transaction.groups
      @content << content_tag(:a, transaction.groups.first.icon.html_safe, href: "/groups/#{transaction.groups}")
    end
    @content
  end

  def group?(transaction)
    @content = tag(:td)
    @content << if transaction.groups
                  transaction.groups.first.icon
                else
                  content_tag(:a, 'Assign', href: "/transactions/#{transaction.id}/edit")
                end
    @content
  end

  def back(transaction)
    @content = if transaction.groups
                 content_tag(:a, 'Back', href: '/assigned_transactions')
               else
                 content_tag(:a, 'Back', href: '/unassigned_transactions')
               end
    @content
  end
end
