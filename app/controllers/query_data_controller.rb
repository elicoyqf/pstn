#coding: utf-8
class QueryDataController < ApplicationController
  def stop
    render layout: 'main_layout'
  end

  def start
    #@q_data = ""
    @q_data = WorkOrder.paginate page: params[:page], per_page: 10
    render layout: 'main_layout'
  end

  def status
    @status = JfName.paginate page: params[:page], per_page: 10
    render layout: 'main_layout'
  end

  def m_status
    @status = JfName.paginate page: params[:page], per_page: 10
    render layout: 'main_layout'
  end

  def mdf_status
    id = params[:id]
    jf = JfName.find(id)
    if jf.status == 0
      jf.update_attribute(:status, 1)
    else
      jf.update_attribute(:status, 0)
    end
    redirect_to action: 'm_status'
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
    q_date1 = pstnr[:date1]
    q_date2 = pstnr[:date2]
    q_bs    = pstnr[:status]
    #构造查询字符串列表

    q_hash  = { id: session[:user_id] }
    q_str   = 'user_id = :id'
    unless q_no.blank?
      q_str       += ' and s_no = :sn'
      q_hash[:sn] = q_no
    end

    unless q_bs.blank?
      q_str       += ' and status = :bs'
      q_hash[:bs] = q_bs
    end

    unless q_date1.blank?
      q_str          += ' and created_at >= :date1'
      q_hash[:date1] = Date.parse q_date1
    end

    unless q_date2.blank?
      q_str          += ' and created_at <= :date2'
      q_hash[:date2] = Date.parse q_date2
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
    @q_data = WorkOrder.where(q_str, q_hash).paginate page: params[:page], per_page: 10
    @wo_con = []
    @q_data.each do |wo|
      tmp = ''
      case wo.s_bt
        when '1'
          tmp += '普通用户'
        when '5'
          tmp += '语音专线或易套餐用户'
        when '7'
          tmp += '预付费用户'
        else
          tmp += '[未知类型用户]'
      end

      tmp += ",虚拟网分组号是:#{wo.s_sg_no}" unless wo.s_sg_no.blank?

      case wo.s_perm
        when '1'
          tmp += ',国内长途'
        when '2'
          tmp += ',市话'
        when '3'
          tmp += ',郊话'
        when '4'
          tmp += ',国际长途'
        when '5'
          tmp += ',紧急'
        else
      end

      case wo.s_df_flag
        when '1'
          tmp += ',放欠费'
        when '2'
          tmp += ',欠费停机'
        when '3'
          tmp += ',停机保号'
        when '4'
          tmp += ',拆机'
        when '51'
          tmp += ',去欠费'
        when '52'
          tmp += ',去欠费开机'
        when '53'
          tmp += ',开机'
        else
      end

      tmp += ',开通来电显示' if wo.s_cid == '1'
      tmp += ',删除来电显示' if wo.s_cid == '2'

      tmp += ',开通热线服务' if wo.s_hs == '1'
      tmp += ',删除热线服务' if wo.s_hs == '2'

      case wo.s_cf
        when '1'
          tmp += ',开通无条件转移'
        when '2'
          tmp += ',开通遇忙转移'
        when '3'
          tmp += ',开通无应答转移'
        when '4'
          tmp += ',删除无条件转移'
        when '5'
          tmp += ',删除遇忙转移'
        when '6'
          tmp += ',删除无应答转移'
        else
      end

      tmp += ",登记呼叫转移号码是:#{wo.s_cf_no}" unless wo.s_cf_no.blank?

      tmp += ',开通呼出限制' if wo.s_cr == '1'
      tmp += ',删除呼出限制' if wo.s_cr == '2'

      tmp += ",呼出限制密码是:#{wo.s_cr_no}" unless wo.s_cr_no.blank?

      tmp += ',开通叫醒服务' if wo.s_mc == '1'
      tmp += ',删除叫醒服务' if wo.s_mc == '2'

      tmp += ',开通缩位拔号' if wo.s_ad == '1'
      tmp += ',删除缩位拔号' if wo.s_ad == '2'

      tmp += '.' unless tmp.blank?

      puts '-'*60 + '>>'
      puts tmp
      puts '-'*60 + '>>'

      @wo_con << tmp
    end

    respond_to do |f|
      f.html { render layout: 'main_layout' }
      f.json { render json: @q_data }
    end
  end
end
