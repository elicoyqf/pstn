class CalendarController < ApplicationController

  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year  = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)

    #此处是为了屏蔽多部门用户相互交叉的交班日志，实际底层是在一起的，显示的时候进行过滤。
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
