#encoding: utf-8
require 'net/telnet'

class WelcomeController < ApplicationController
  include WelcomeHelper

  def index

  end

  def p_stop
    render layout: "main_layout"
  end

  def p_start
    render layout: "main_layout"
  end

  def main
    render layout: "main_layout"
  end

  #将数据插入数据库中
  #其中wo_type(工单类型)规定如下示：
  #   0:无意义
  #   1：放欠费
  #   2:欠费停机
  #   3:停机
  #   4:拆机
  #   5:去来电显示
  #   6:其它...
  #
  # ========================
  #    从50开始相反操作
  #    50:无意义
  #    51:去欠费
  #    52:去欠费停机
  #    53:开机
  #    54:新装机
  #    55:开来电显示
  #    56:其它...
  #
  #
  # 其中的emerg(是否紧急)规定如下示：
  #    0：非紧急
  #    1：紧急
  #
  #
  #
  #split_data(data,下单用户id，数据类型，是否紧急)

  def pstn_stop
    #类型为1
    #紧急类型为0，即非紧急
    user     = User.first
    @number  = params[:number]
    @wo_type = params[:wo_type]
    @emerg   = params[:emerg]
    puts "--------------->"
    puts @number
    puts @wo_type
    puts @emerg
    puts "--------------->"
    split_data(@number, user.id, @wo_type.to_i, @emerg.to_i)
    if @emerg.to_i == 1
      puts "----------进入立即制做模式！"
      #立即模式还需要完善
      wo_emerg = PstnStop.find_all_by_emerg_and_user_id_and_status_and_work_order_t(
          1,
          user.id,
          "pending",
          @wo_type.to_i
      )
      emerg_complete_data wo_emerg
    end

  end

end
