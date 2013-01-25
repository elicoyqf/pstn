#encoding: utf-8
namespace :database do
  desc '定时执行将数据库里面的数据进行更新'
  task :woprocess => :environment do
    te     = WorkOrderProcess::BackgroundProcedure.new
    new_or = WorkOrder.where('created_at >= ? And created_at <= ? and status = ?', Time.now.at_beginning_of_day,
                             Time.now.at_beginning_of_day + 1.day, 2)
    te.wo_make new_or
  end

  desc '定时对工单进行检查'
  task :wocheck => :environment do
    te     = WorkOrderProcess::BackgroundProcedure.new
    new_or = WorkOrder.where('created_at >= ? And created_at <= ?', Time.now.at_beginning_of_day - 1.day,
                             Time.now.at_beginning_of_day)
    te.wo_make new_or
  end

  desc '定时对失败工单进行重做'
  task :wofailcheck => :environment do
    te     = WorkOrderProcess::BackgroundProcedure.new
    new_or = WorkOrder.where('status = ?', 3)
    te.wo_make new_or
  end

  desc '测试是否生效'
  task :test => :environment do
    te     = WorkOrderProcess::BackgroundProcedure.new
    te.testrake
  end
end