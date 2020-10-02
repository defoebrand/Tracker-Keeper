module UsersHelper
  def date
    @content = tag(:div, class: 'date')
    day = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    @content << content_tag(:span, "Today is #{day[Time.now.wday]}")
    @content << tag(:br)
    @content << content_tag(:span, Time.now.strftime('%d %b. %Y').to_s)
    @content
  end

  def greeting
    @content = tag(:div)
    greetings = ["Shouldn't you be sleeping", "Up early or haven't slept",
                 'Good Morning', 'Good Afternoon', 'Good Evening', 'Working late today', "Ahh, it's midnight"]

    @content << if [0, 1, 5].include?(index)
                  content_tag(:h2, "#{greetings[Time.now.hour / 4]} #{@user.name}?")
                else
                  content_tag(:h2, "#{greetings[Time.now.hour / 4]} #{@user.name}!")
                end
  end
end
