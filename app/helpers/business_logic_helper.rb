module BusinessLogicHelper
    #分割数据并且将数据插入到数据库中
  def split_data(content)
    linenu = content.to_s.split(/\n/)

    if linenu.length > 1
      puts "line nu is :#{linenu}"
      #将数据插入到数据库或者直接执行
      #删除掉空值的数据
      linenu.delete_if { |x| x.empty? }
      puts "line nu is :#{linenu}"
      #插入数据库
      linenu
    else
      linefh = content.to_s.split(/;/)
      puts "linffh is :#{linefh}"
      #将数据插入到数据库或者直接执行
      #删除掉空值的数据
      linefh.delete_if { |x| x.empty? }
      puts "linffh is :#{linefh}"
      linefh
    end
  end

end
