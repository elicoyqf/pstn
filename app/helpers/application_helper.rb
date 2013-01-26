#encoding: utf-8
LOG_TYPE = { '日常' => '2', '故障' => '1', '要点' => '3', '调令' => '4', '会议令' => '5' }
SOFT_VERSION = 'V2.2'
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
end
