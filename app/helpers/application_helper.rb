#encoding: utf-8
module ApplicationHelper
  def full_title(page_title)
    base_title = "自动停复机系统"
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
