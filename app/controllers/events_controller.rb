#coding: utf-8
class EventsController < ApplicationController
  #Get /events/query
  def query
    render layout: 'main_layout'
  end

  def q_submit
    content = params[:event][:content]
    date1   = params[:event][:date1]
    date2   = params[:event][:date2]
    q_sql   = ''
    q_value = []
    unless content.blank?
      q_sql += 'name like ? '
      q_value << '%' + content + '%'
    end

    unless date1.blank?
      if q_sql.blank?
        q_sql += 'created_at >= ? '
        q_value << date1
      else
        q_sql += 'and created_at >= ? '
        q_value << date1
      end
    end

    unless date2.blank?
      if q_sql.blank?
        q_sql += 'created_at <= ?'
        q_value << date2
      else
        q_sql += 'and created_at <= ?'
        q_value << date2
      end
    end
    @events = Event.where(q_sql, *q_value)
    render :template => 'events/index', layout: 'main_layout'
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html { render layout: 'main_layout' }
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'main_layout' }
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html { render layout: 'main_layout' }
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    render layout: 'main_layout'
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    #添加一个新的更新用户id的参数。
    params[:event][:update_id] = session[:user_id]
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to '/log_book/logging' }
      format.json { head :no_content }
    end
  end
end
