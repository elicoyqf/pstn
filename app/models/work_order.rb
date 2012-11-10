#encoding: utf-8
class WorkOrder < ActiveRecord::Base
  attr_accessible :user_id, :s_cr_no, :s_cf_no, :priority, :s_ad, :s_cr, :s_mc, :s_hs, :s_cf, :s_perm, :s_bt, :s_no, :s_df_flag,
                  :s_sg_no, :s_cid, :status
  belongs_to :user
  validates :s_no, numericality: { message: '批量输入的号码存在非数字输入，请检查' }
  validates :s_no, length: { is:7,message: '批量输入的号码存在超过7位的号码，请检查' }

end
