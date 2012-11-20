require "net/telnet"
class BusinessLogicController < ApplicationController
  include ApplicationHelper
  include BusinessLogicHelper

  def change
    render layout: "main_layout"
  end

  def bl_submit
    #s_ad:缩位拔号
    #s_cr:呼出限制
    #s_cr_no:呼出限制密码
    #s_mc:叫醒服务
    #s_hs:热线服务
    #s_cf_no:转移到号码
    #s_cf:呼叫转移
    #s_perm:用户权限
    #s_bt:用户类型
    #s_no:用户号码
    #b_s_no:批量输入号码
    #s_df_flag:欠费标志
    #s_sg_no:用户组号
    #s_cid:来电显示
    #s_bp:优先级
    #其中的欠费标志有如下内容:
    #   1：放欠费
    #   2:欠费停机
    #   3:停机
    #   4:拆机
    #   51:去欠费
    #   52:去欠费停机
    #   53:开机
    #"b_s_no"=>"6172100\n6125678", "s_no"=>"6172100", "s_bt"=>"0", "s_perm"=>"0", "s_cf"=>"1",
    #"s_cf_no"=>"13826386421", "s_hs"=>"hs", "s_mc"=>"mc", "s_cr"=>"cr",
    #"s_cr_no"=>"1234", "s_ad"=>"ad", "s_df_flag"=>"1", "s_sg_no"=>"10"
    #todo:接收到用户数据后进行分割保存并且进行后台操作。
    s_cf_no   = params[:s_cf_no]
    s_cr_no   = params[:s_cr_no]
    s_ad      = params[:s_ad]
    s_cr      = params[:s_cr]
    s_mc      = params[:s_mc]
    s_hs      = params[:s_hs]
    s_cf      = params[:s_cf]
    s_perm    = params[:s_perm]
    s_bt      = params[:s_bt]
    s_no      = params[:s_no]
    s_df_flag = params[:s_df_flag]
    s_sg_no   = params[:s_sg_no]
    s_cid     = params[:s_cid]
    b_s_no    = params[:b_s_no]
    #通过使用优先级替代了紧急状态标识
    #emerg = 1
    s_bp      = params[:s_bp]
    status    = 0
    #todo:还需要做一个优先级标志，尽量安排新装等业务优先办理。(已完成)
    if b_s_no.blank?
      if s_no =~ /\d{7}/
        WorkOrder.create(user_id: 1, status: status, s_ad: s_ad, s_bt: s_bt, s_cf: s_cf, s_cf_no: s_cf_no,
                         s_cid:   s_cid, s_cr: s_cr, s_cr_no: s_cr_no, s_df_flag: s_df_flag,
                         s_hs:    s_hs, s_mc: s_mc, s_no: s_no, s_perm: s_perm, s_sg_no: s_sg_no, priority: s_bp)
        #todo:  一般而言，单个数据输入需要马上进行后台操作。
        @er = '[{"one":"normal"}]'
      else
        @er = '[{"one":"errors"},{"two":"errors"}]'
      end
    else
      #  需要对批量数据进行分割然后插入数据库中
      s_a_no = split_data b_s_no
      @er    = ''
      s_a_no.each do |no|
        if no !~ /\d{7}/
          #返回一数组的json给前台做判断，没有具体意义
          @er = '[{"one":"errors"},{"two":"errors"}]'
        else
          @er = '[{"one":"normal"}]'
        end

      end

      if @er =~ /normal/
        s_a_no.each do |no|
          @wo = WorkOrder.create(user_id: 1, status: status, s_ad: s_ad, s_bt: s_bt, s_cf: s_cf, s_cf_no: s_cf_no,
                                 s_cid:   s_cid, s_cr: s_cr, s_cr_no: s_cr_no, s_df_flag: s_df_flag, s_hs: s_hs,
                                 s_mc:    s_mc, s_no: no, s_perm: s_perm, s_sg_no: s_sg_no, priority: s_bp)
        end
      end
    end
    wo_make
    respond_to do |f|
      f.json { render json: @er }
    end
  end

  def wo_make
    #优先做新装业务，即优先级为1的(work_orders:priotity = 1)
    new_or = WorkOrder.find_all_by_priority_and_status(1, 0)

    new_or.each do |x|
      no    = x.s_no.to_i
      cr_no = x.s_cr_no
      cf_no = x.s_cf_no
      bt    = x.s_bt
      sg_no = x.s_sg_no
      perm  = x.s_perm
      dn    = DnTable.where("dn_start <= ? and ? <= dn_end ", no, no).first

      unless dn.blank?
        #终端IP地址
        ip_address = dn.jf_name.ip_address
        #生成命令行字符串
        cmd        = "4294:dn=k'#{no}"
        subctrl    = 'subctrl=1'
        ad_cmd     = ''
        cf_cmd     = ''
        #todo:需要在用户类型和组号二选一，已经在前台完成限制了，后台不用管它。
        (cmd += ",subgrp=#{bt}") unless x.s_bt.blank?
        (cmd += ",subgrp=#{sg_no}") unless x.s_sg_no.blank?
        #todo:用户权限的生成字符串还需要根据不同机房生成不同的权限字符
        (cmd += ",ocb=modify&perm&#{perm}") unless x.s_perm.blank?

        case x.s_cf
          when "1"
            subctrl += "&cfwdu"
          when "2"
            subctrl += "&cfwdbsub"
          when "3"
            subctrl += "&cfwdnor"
          else
            puts "nothing."
        end

        #todo:如果设置了呼叫转移的号码则需要另外再将呼转号码激活
        unless cf_no.blank?
          cf_cmd = "4294:dn=k'xxxx,cfwdu=1&xxxx"
        end

        if !x.s_cr.blank? and !x.s_cr_no.blank?
          cmd     += ",password=1&"+"\""+"#{cr_no}"+"\""
          subctrl += '&ocbvar'
        elsif !x.s_cr.blank? and x.s_cr_no.blank?
          cmd     += ",password=1&"+"\""+"8888"+"\""
          subctrl += '&ocbvar'
        end

        (cmd += ",subgrp=1") unless x.s_df_flag.blank?
        (ad_cmd = "141:dn=k'#{no},abdrepsz=20.") unless x.s_ad.blank?
        (subctrl += "&fdcto") unless x.s_hs.blank?
        (subctrl += "&ac24hour") unless x.s_mc.blank?
        (cmd += ",23=1&1") unless x.s_cid.blank?
        if subctrl =~ /^subctrl=1$/
          cmd += "."
        else
          cmd += ","+subctrl+ "."
        end

        puts ad_cmd unless ad_cmd.blank?
        puts cmd
        puts cf_cmd

      end

    end

  end

  def pstn_data(ip_address, cmd)
    telnet = Net::Telnet.new(
        "Host"     => ip_address,
        "Port"     => 10001,
        "Timeout"  => 10,
        "Waittime" => 5
    )
    #条件：机房登录状态必须为1(jf_name:status = 1)

    begin
      telnet.puts "\n"
      telnet.puts "\n"
      telnet.puts "\n"
      telnet.waitfor(/>/) { |c| print c }
      telnet.puts "MM"

      telnet.waitfor(/USERID:/) { |c| print c }
      telnet.puts "PW0009"

      telnet.waitfor(/PASSWORD:/) { |c| print c }
      telnet.puts "PW0009"

      telnet.puts "4294:dn=k'6994951,subgrp=5."
      telnet.waitfor(/>/) { |c| print c }
    rescue
      #为了防止未超时的会话，直接输入命令即可。
      telnet.puts "4294:dn=k'6994951,subgrp=5."
      telnet.waitfor(/>/) { |c| print c }
    ensure
      telnet.close
    end
  end

end
