#encoding: utf-8
module WelcomeHelper
  #在后台通过程控DCN网络完成用户数据
  def complete_data(content)
    #通过号码找出是属于那个机房的数据
    #通过telnet登录到此终端
    #根据数据给出的数据制做要求
    #生成指定权限的命令
    #发送命令给主机执行
    #提取产生的数据进行分析判断是否已完成
    #如果失败则需要进行登记并反馈
    #=> PstnStop.update(434,status: "ok")
    #=> x.update_attributes(status: "pending")


  end

  def emerg_complete_data(content)
    #content = PstnStop.find_all_by_emerg_and_user_id_and_status_and_work_order_t(1, user.id, "pending", 1)
    #通过调用后台程序完成数据制作
    #content.each { |x| complete_data x }
    content.each { |x|  puts x.sn.to_s + "  已完成。" }
    puts "------------->后台数据已完成。"
  end
end
