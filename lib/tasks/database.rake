#encoding: utf-8
namespace :database do
  desc '定时执行将数据库里面的数据进行更新'
  task :woprocess => :environment do
    te     = WorkOrderProcess::BackgroundProcedure.new
    new_wo = WorkOrder.where('created_at >= ? and created_at <= ? and status = ?', Time.now.at_beginning_of_day,
                             Time.now.at_beginning_of_day + 1.day, 2).limit(35)
    te.wo_make new_wo unless new_wo.blank?
  end

  desc '定时对昨日的工单进行检查'
  task :wocheck => :environment do
    te           = WorkOrderProcess::BackgroundProcedure.new
    yesterday_wo = WorkOrder.where('created_at >= ? and created_at <= ?',
                                   Time.now.at_beginning_of_day - 1.day,
                                   Time.now.at_beginning_of_day).where(:check => 2).limit(200)
    te.wo_make(yesterday_wo, 1) unless yesterday_wo.blank?
  end

  desc '定时对昨日失败工单进行重做'
  task :wofailcheck => :environment do
    te      = WorkOrderProcess::BackgroundProcedure.new
    fail_wo = WorkOrder.where('status = ? and created_at >= ? and created_at <= ?', 3,
                              Time.now.at_beginning_of_day - 1.day,
                              Time.now.at_beginning_of_day).limit(200)
    te.wo_make fail_wo unless fail_wo.blank?
  end

  desc '定时对节假日值守呼叫进行登记'
  task :holidays_cfwd => :environment do
    hcfwdreg = CfwdReg.where('c_date = ? and status = 1 and cf_type = 1', Time.now.at_beginning_of_day).last
    unless hcfwdreg.blank?
      te = WorkOrderProcess::BackgroundProcedure.new
      te.cfwd_make hcfwdreg.mobile, 1, hcfwdreg.id
    end
  end

  desc '定时对中午值守呼叫进行登记'
  task :noon_cfwd => :environment do
    hcfwdreg = CfwdReg.where('c_date = ? and status = 1 and cf_type = 3', Time.now.at_beginning_of_day).last
    unless hcfwdreg.blank?
      te = WorkOrderProcess::BackgroundProcedure.new
      te.cfwd_make hcfwdreg.mobile, 1, hcfwdreg.id
    end
  end

  desc '定时对中午值守呼叫进行取消'
  task :noon_cancel => :environment do
    hcfwdreg = CfwdReg.where('c_date = ? and cf_type = 3', Time.now.at_beginning_of_day)
    unless hcfwdreg.blank?
      te = WorkOrderProcess::BackgroundProcedure.new
      te.cfwd_make 1, 2
    end
  end

  desc '定时对晚班值守呼叫进行登记'
  task :night_cfwd => :environment do
    hcfwdreg = CfwdReg.where('c_date = ? and status = 1 and cf_type = 2', Time.now.at_beginning_of_day).last
    unless hcfwdreg.blank?
      te = WorkOrderProcess::BackgroundProcedure.new
      te.cfwd_make hcfwdreg.mobile, 1, hcfwdreg.id
    end
  end

  desc '定时对值守呼叫进行取消'
  task :cfwd_cancel => :environment do
    #到时间点后直接删除就好
    te = WorkOrderProcess::BackgroundProcedure.new
    te.cfwd_make 1, 2
  end

  desc '测试是否生效'
  task :test => :environment do
    te = WorkOrderProcess::BackgroundProcedure.new
    te.testrake
  end
end