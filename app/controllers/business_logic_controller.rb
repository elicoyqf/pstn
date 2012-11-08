class BusinessLogicController < ApplicationController
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
    #"b_s_no"=>"6172100\n6125678", "s_no"=>"6172100", "s_bt"=>"0", "s_perm"=>"0", "s_cf"=>"1",
    #"s_cf_no"=>"13826386421", "s_hs"=>"hs", "s_mc"=>"mc", "s_cr"=>"cr",
    #"s_cr_no"=>"1234", "s_ad"=>"ad", "s_df_flag"=>"1", "s_sg_no"=>"10"
    #todo:接收到用户数据后进行分割保存并且进行后台操作。

  end
end
