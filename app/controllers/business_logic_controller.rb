class BusinessLogicController < ApplicationController
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
    #s_pp:优先级
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
      #  直接插入数据库中
      WorkOrder.create(user_id: 1, status: status, s_ad: s_ad, s_bt: s_bt, s_cf: s_cf, s_cf_no: s_cf_no,
                       s_cid:   s_cid,
                       s_cr:    s_cr, s_cr_no: s_cr_no, s_df_flag: s_df_flag, s_hs: s_hs, s_mc: s_mc, s_no: s_no, s_perm: s_perm,
                       s_sg_no: s_sg_no, priority: s_bp)
      #todo:  一般而言，单个数据输入需要马上进行后台操作。

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
                                 s_cid:   s_cid,
                                 s_cr:    s_cr, s_cr_no: s_cr_no, s_df_flag: s_df_flag, s_hs: s_hs, s_mc: s_mc, s_no: no,
                                 s_perm:  s_perm,
                                 s_sg_no: s_sg_no, priority: s_bp)
        end
      end
    end

    respond_to do |f|
      f.json { render json: @er }
    end
  end
end
