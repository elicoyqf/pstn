#coding: utf-8
class QueryDataController < ApplicationController
  def stop
    render layout: "main_layout"
  end

  def start
    #@q_data = ""
    @q_data = PstnStop.paginate page: params[:page], per_page: 10
    render layout: "main_layout"
  end

  def q_cont_data
    #{q_no: q_no,q_bt: q_bt,q_date1: q_date1,q_date2: q_date2,q_bs: q_bs}
    # q_no    : 查询号码
    # q_bt    : 查询业务类型
    # q_date1 : 开始时间
    # q_date1 : 结束时间
    # q_bs    : 后台数据状态

    pstnr   = params[:pstn_stop]
    q_no    = pstnr[:sn]
    q_bt    = pstnr[:work_order_t]
    q_date1 = pstnr[:date1]
    q_date2 = pstnr[:date2]
    q_bs    = pstnr[:status]
    #构造查询字符串列表
=begin
    q_no    = params[:q_no]
    q_bt    = params[:q_bt]
    q_date1 = params[:q_date1]
    q_date2 = params[:q_date2]
    q_bs    = params[:q_bs]
=end

    q_hash = { id: 1 }
    q_str  = "user_id = :id"
    unless q_no.blank?
      q_str      += " and sn = :sn"
      q_hash[:sn]=q_no
    end

    unless q_bt.blank?
      q_str      += " and work_order_t = :bt"
      q_hash[:bt]=q_bt
    end

    unless q_bs.blank?
      q_str      += " and status = :bs"
      q_hash[:bs]=q_bs
    end
    unless q_date1.blank?
      q_str         += " and created_at >= :date1"
      q_hash[:date1]=Date.parse q_date1
    end
    unless q_date2.blank?
      q_str         += " and created_at <= :date2"
      q_hash[:date2]=Date.parse q_date2
    end

    puts q_hash
    puts "--------->" + q_str
    #content = PstnStop.find_all_by_emerg_and_user_id_and_status_and_work_order_t(1, user.id, "pending", 1)
    #通过调用后台程序完成数据制作
    #分析Hash列表的key值

    #content = PstnStop.where("user.id = ? and sn = ? and work_order_t = ? and status = ?  and created_at >= ? and
    #created_at <= ?",
    #{id,sn,q_bt,q_bs,date1,date2})

    #content = PstnStop.where(q_str,)
    #@q_data = PstnStop.paginate page: params[:page], per_page: 10
    #@q_data = PstnStop.where(q_str,q_hash).paginate page: params[:page], per_page: 10
    @q_data = PstnStop.where(q_str, q_hash).paginate page: params[:page], per_page: 10
    puts "---------------q_data"
    puts @q_data
    puts "---------------q_data"
    respond_to do |f|
      f.html { render layout: "main_layout" }
      f.json { render json: @q_data }
    end
  end
end
