#encoding: utf-8
namespace :database do
  desc '定时执行将数据库里面的数据进行更新'
  task :woprocess => :environment do
    te     = WorkOrderProcess::BackgroundProcedure.new
    new_wo = WorkOrder.where('created_at >= ? and created_at <= ? and status = ?', Time.now.at_beginning_of_day,
                             Time.now.at_beginning_of_day + 1.day, 2).limit(30)
    te.wo_make new_wo unless new_wo.blank?
  end

  desc '定时对昨日的工单进行检查'
  task :wocheck => :environment do
    te           = WorkOrderProcess::BackgroundProcedure.new
    yesterday_wo = WorkOrder.where('created_at >= ? and created_at <= ?',
                                   Time.now.at_beginning_of_day - 1.day,
                                   Time.now.at_beginning_of_day).where(:check => 2).limit(300)
    te.wo_make yesterday_wo unless yesterday_wo.blank?
  end

  desc '定时对昨日失败工单进行重做'
  task :wofailcheck => :environment do
    te      = WorkOrderProcess::BackgroundProcedure.new
    fail_wo = WorkOrder.where('status = ? and created_at >= ? and created_at <= ?', 3,
                              Time.now.at_beginning_of_day - 1.day,
                              Time.now.at_beginning_of_day).limit(200)
    te.wo_make fail_wo unless fail_wo.blank?
  end

  desc '测试是否生效'
  task :test => :environment do
    te = WorkOrderProcess::BackgroundProcedure.new
    te.testrake
  end
end