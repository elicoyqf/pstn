#encoding: utf-8
LOG_TYPE = { '日常' => '2', '故障' => '1', '要点' => '3', '调令' => '4', '会议令' => '5' }
module ApplicationHelper
  def full_title(page_title)
    base_title = '韶关铁通业务运营支撑系统'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def split_data(content)
    linenu = content.to_s.split(/\n/)

    if linenu.length > 1
      puts "line nu is :#{linenu}"
      linenu.delete_if { |x| x.empty? }
      puts "line nu is :#{linenu}"
      linenu
    else
      linefh = content.to_s.split(/;/)
      puts "linffh is :#{linefh}"
      linefh.delete_if { |x| x.empty? }
      puts "linffh is :#{linefh}"
      linefh
    end
  end

  def make_data
    #优先做新装业务，即优先级为1的(work_orders:priotity = 1)


    #条件：机房登录状态必须为1(jf_name:status = 1)


    telnet = Net::Telnet.new(
        "Host"     => '192.166.16.3',
        "Port"     => 10001,
        "Timeout"  => 10,
        "Waittime" => 5
    )

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
