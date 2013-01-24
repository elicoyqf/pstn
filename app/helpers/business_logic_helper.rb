require 'net/telnet'

module BusinessLogicHelper
=begin
  def make_data()

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
      puts "<----------------------------->1"

      telnet.waitfor(/USERID:/) { |c| print c }
      telnet.puts "PW0009"

      puts "<----------------------------->2"
      telnet.waitfor(/PASSWORD:/) { |c| print c }
      telnet.puts "PW0009"
      puts "<----------------------------->3"

      telnet.puts "4294:dn=k'6994951,subgrp=5."
      telnet.waitfor(/>/) { |c| print c }
    rescue
      #为了防止未超时的会话，直接输入命令即可。
      telnet.puts "4294:dn=k'6994951,subgrp=5."
      telnet.waitfor(/>/) { |c| print c }
      puts "<----------------------------->4"
    ensure

      telnet.close

    end
  end
=end

end
