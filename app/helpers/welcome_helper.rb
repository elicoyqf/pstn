#encoding: utf-8
module WelcomeHelper
  #分割数据并且将数据插入到数据库中
  def split_data(content, user_id, type, emerg)
    linenu = content.to_s.split(/\n/)

    if linenu.length > 1
      puts "line nu is :#{linenu}"
      #将数据插入到数据库或者直接执行
      #删除掉空值的数据
      linenu.delete_if { |x| x.empty? }
      puts "line nu is :#{linenu}"
      #插入数据库
      linenu.each { |x| PstnStop.create(user_id: user_id, sn: x, emerg: emerg, status: "pending", work_order_t: type) }
    else
      linefh = content.to_s.split(/;/)
      puts "linffh is :#{linefh}"
      #将数据插入到数据库或者直接执行
      #删除掉空值的数据
      linefh.delete_if { |x| x.empty? }
      puts "linffh is :#{linefh}"
      #插入数据库
      linefh.each { |x| PstnStop.create(user_id: user_id, sn: x, emerg: emerg, status: "pending", work_order_t: type) }
    end
  end

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

    begin
      telnet = Net::Telnet.new('Host'    => '61.235.93.6',
                               'Port'    => 23,
                               "Timeout" => 10,)
      telnet.waitfor(/name:/) { |c| print c; @stopinfo << c << '<br/>' }
      telnet.puts("huawei")
      telnet.waitfor(/word:/) { |c| print c; @stopinfo << c << '<br/>' }
      telnet.puts("sgcsss6503!@#456")
      telnet.waitfor(/>/) { |c| print c; @stopinfo << c << '<br/>' }
      telnet.puts("dis device") { |c| print c; @stopinfo << c << '<br/>' }
      telnet.waitfor(/>/) { |c| print c; @stopinfo << c << '<br/>' }
      puts "\n----------------something."
      @stopinfo.gsub!(/(device)/, '\1<br />')
      @stopinfo.gsub!(/(Ver)/, '\1<br />')
      @stopinfo.gsub!(/(-1018)/, '\1<br />')
      @stopinfo.gsub!(/(None)/, '\1<br />')
      puts @stopinfo
      puts "----------------something.\n"
      telnet.puts("quit") { |c| print c; @stopinfo << c << '<br/>' }

    rescue
      puts "error:#{$!} at:#{$@}\n"
    ensure
      telnet.close
    end
  end

  def emerg_complete_data(content)
    #content = PstnStop.find_all_by_emerg_and_user_id_and_status_and_work_order_t(1, user.id, "pending", 1)
    #通过调用后台程序完成数据制作
    #content.each { |x| complete_data x }
    content.each { |x|  puts x.sn.to_s + "  已完成。" }
    puts "------------->后台数据已完成。"
  end
end
