#encoding : utf-8
module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :height => 600,
      :day_names_height => 30,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%Y年 %B"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>"    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      #%(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name.truncate(9))}</a>)
      %(<a href="/log_book/switch?id=#{event.id}" title="#{h(event.name)}">#{h(event.name.truncate(9))}</a>)
    end
  end
end
