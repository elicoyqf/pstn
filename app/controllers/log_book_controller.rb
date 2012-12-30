class LogBookController < ApplicationController
  def logging
    @logs = Logbook.all
    render layout: 'main_layout'
  end

  def log_submit
    a = params[:my_log]
    t = params[:log_type]
    t = '2' if t.blank?
    Logbook.create(user_id: 1, content: "#{a}", log_type: "#{t}")
    redirect_to action: 'logging'
  end

  def log_type1
    @logs = Logbook.find_all_by_log_type('1')
    render action: 'logging', layout: 'main_layout'
  end

  def log_type2
    @logs = Logbook.find_all_by_log_type('2')
    render action: 'logging', layout: 'main_layout'
  end
end
