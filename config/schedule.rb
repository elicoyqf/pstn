# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more:

=begin
every 3.hours do
  runner "MyModel.some_process"
  rake "my:rake:task"
  command "/usr/bin/my_great_command"
end

every 1.day, :at => '4:30 am' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end

every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  runner "SomeModel.ladeeda"
end

every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
  runner "Task.do_something_great"
end

every '0 0 27-31 * *' do
  command "echo 'you can use raw cron syntax too'"
end

# run this task only on servers with the :app role in Capistrano
# see Capistrano roles section below
every :day, :at => '12:20am', :roles => [:app] do
  rake "app_server:task"
end
=end
env :PATH, ENV['PATH']
#添加环境变量,否则找不到bundle命令。
set :output, "#{path}/log/whenever.log" #设置日志输出文件

#每天的正常上班时间内，一个小时内做4次，每次15分钟
every '8,20,40,50 8-23 * * *' do
  rake 'database:woprocess'
end

#每天的晚班时间内做检查，从1点开始做到7点
every '20 0-7 * * *' do
  rake 'database:wocheck'
end

#每天的8点20复查工单失败的那部分工单
every '20 8 * * *' do
  rake 'database:wofailcheck'
end

#每天的8点35登记转节假日值班呼转
every '35 8 * * *' do
  rake 'database:holidays_cfwd'
end

#每天的17点35登记转晚班值班呼转
every '35 17 * * *' do
  rake 'database:night_cfwd'
end

#每天的20点58取消呼转
every '58 22 * * *' do
  rake 'database:cfwd_cancel'
end

#每天的0点10取消呼转
every '10 0 * * *' do
  rake 'database:cfwd_cancel'
end

#每天的0点12取消呼转
every '12 0 * * *' do
  rake 'database:cfwd_cancel'
end

#每天的11点56登记是中午值班呼转
every '56 11 * * *' do
  rake 'database:noon_cfwd'
end

#每天的13点56取消中午值班呼转
every '56 13 * * *' do
  rake 'database:noon_cancel'
end

#每天的14点10取消中午值班呼转
every '10 14 * * *' do
  rake 'database:noon_cancel'
end

#每隔20分钟检测一次机房状态是否正常
every '*/20 * * * *' do
  rake 'database:detect_ss'
end