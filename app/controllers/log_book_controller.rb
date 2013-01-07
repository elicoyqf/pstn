class LogBookController < ApplicationController
  def logging
    @logs = Event.where('created_at >= ? And created_at <= ?', Time.now.at_beginning_of_day,
                        Time.now.at_beginning_of_day + 1.day)
    render layout: 'main_layout'
  end

  def log_submit
    id = session[:user_id]
    a = params[:my_log]
    t = params[:log_type]
    t = '2' if t.blank?
    Event.create(user_id: id, name: "#{a}", event_type: "#{t}",start_at: Time.now.at_beginning_of_day + 8.5.hour,
                 end_at: Time.now.at_beginning_of_day + 18.hour)
    redirect_to action: 'logging'
  end

  def log_type1
    @logs = Event.find_all_by_event_type('1')
    render action: 'logging', layout: 'main_layout'
  end

  def log_type2
    @logs = Event.find_all_by_event_type('2')
    render action: 'logging', layout: 'main_layout'
  end

  def log_type3
    @logs = Event.find_all_by_event_type('3')
    render action: 'logging', layout: 'main_layout'
  end

  def switch
    e_id  = params[:id]
    e     = Event.find(e_id.to_i)
    @logs = Event.where('created_at >= ? And created_at <= ?', e.created_at.at_beginning_of_day,
                        e.created_at.at_beginning_of_day + 1.day)
    render action: 'logging', layout: 'main_layout'
  end
end
