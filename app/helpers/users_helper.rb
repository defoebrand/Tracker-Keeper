module UsersHelper
  def date
    @content = tag(:div, class: 'date')
    day = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    @content << content_tag(:span, "Today is #{day[Time.now.wday]}")
    @content << tag(:br)
    @content << content_tag(:span, DateTime.now.strftime('%d %b. %Y').to_s)
    @content
  end

  def greeting
    @content = tag(:div)
    greetings = ['Good Morning', 'Good Afternoon', 'Good Evening']
    if DateTime.now.hour > 18
      index = 2
    elsif DateTime.now.hour > 12
      index = 1
    elsif DateTime.now.hour > 8
      index = 0
    end
    @content << content_tag(:h2, "#{greetings[index]} #{@user.name}!")
  end
end
