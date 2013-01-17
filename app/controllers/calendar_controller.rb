class CalendarController < ApplicationController

  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year  = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)

    @event_strips.each do |x|
      x.each_with_index do |y,i|
        unless y.blank?
          if y.user.department.id != session[:d_id]
            x.fill(nil,i,1)
          end
        end
      end
    end

    render layout: 'main_layout'
  end

end
