module UsersHelper
  # def date
  #   @content = tag(:div, class: 'date')
  #   day = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
  #   @content << content_tag(:span, "Today is #{day[Time.now.wday]}")
  #   @content << tag(:br)
  #   @content << content_tag(:span, Time.now.strftime('%d %b. %Y').to_s)
  #   @content
  # end
  #
  # def greeting
  #   @content = tag(:div)
  #   greetings = ["Up early or haven't slept", 'Good Morning',
  #                'Good Afternoon', 'Good Evening', 'Working late today',
  #                "Shouldn't you be sleeping"]
  #
  #   index = if Time.now.hour > 22
  #             4
  #           elsif Time.now.hour > 18
  #             3
  #           elsif Time.now.hour > 12
  #             2
  #           elsif Time.now.hour > 8
  #             1
  #           elsif Time.now.hour > 4
  #             0
  #           else
  #             5
  #           end
  #
  #   @content << if [0, 4, 5].include?(index)
  #                 content_tag(:h2, "#{greetings[index]} #{@user.name}?")
  #               else
  #                 content_tag(:h2, "#{greetings[index]} #{@user.name}!")
  #               end
  # end
end
