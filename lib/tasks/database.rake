#encoding: utf-8
namespace :database do
  include WorkOrderProcess
  desc "定时执行将数据库里面的数据进行更新"
  task :cleanDatabase => :environment do
    wo_make
  end
end