#encoding: utf-8
require 'net/telnet'

class WelcomeController < ApplicationController
  skip_before_filter :authenticate, :only => [:index, :main]
  include ApplicationHelper
  include WelcomeHelper

  def index

  end

  def logout
    reset_session
    redirect_to root_url
  end

  def p_stop
    render layout: 'main_layout'
  end

  def p_start
    render layout: 'main_layout'
  end

  def main
    name = params[:name]
    pass = params[:pass]
    user = User.find_by_name(name)
    if user.blank?
      flash[:error] = '用户名或密码输入不正确，请重试!'
      redirect_to root_path
    else
      if Digest::MD5.hexdigest(pass) == user.password
        session[:user_id] = user.id
        session[:name]    = user.alias_name
        session[:level]   = user.level
        session[:d_id]    = user.department_id
        render layout: 'main_layout'
      else
        flash[:error] = '用户名或密码输入不正确，请重试!'
        redirect_to root_path
      end
    end
  end

  #将数据插入数据库中
  #其中欠费标志(s_df_flag)规定如下示：
  #   0:无意义
  #   1：放欠费
  #   2:欠费停机
  #   3:停机
  #   4:拆机
  #
  # ========================
  #    从50开始相反操作
  #    50:无意义
  #    51:去欠费
  #    52:去欠费停机
  #    53:开机
  #    54:新装机
  #

  def pstn_stop
    user      = User.first
    number    = params[:number]
    s_df_flag = params[:wo_type]
    puts "--------------->"
    a_no = split_data number
    @er  = ''

    a_no.each do |no|
      if no !~ /^\d{7}$/
        #返回一数组的json给前台做判断，没有具体意义
        @er = '[{"one":"errors"},{"two":"errors"}]'
      else
        @er = '[{"one":"normal"}]'
      end
    end

    if @er =~ /normal/
      a_no.each do |no|
        @wo = WorkOrder.create(user_id: user.id, status: 2, s_df_flag: s_df_flag, s_no: no, priority: 5)
      end
    end

    respond_to do |f|
      f.json { render json: @er }
    end
  end
end
