class CreateWorkOrders < ActiveRecord::Migration
  #s_ad:缩位拔号
  #s_cr:呼出限制
  #s_cr_no:呼出限制密码
  #s_mc:叫醒服务
  #s_hs:热线服务
  #s_cf_no:转移到号码
  #s_cf:呼叫转移
  #s_perm:用户权限
  #s_bt:用户类型
  #s_no:用户号码
  #b_s_no:批量输入号码
  #s_df_flag:欠费标志
  #s_sg_no:用户组号
  def change
    create_table :work_orders do |t|
      t.integer :user_id, null: false
      t.integer :s_cf_no
      t.integer :s_cr_no
      t.integer :emerg
      t.integer :status
      t.string :s_ad
      t.string :s_cr
      t.string :s_mc
      t.string :s_hs
      t.string :s_cf
      t.string :s_perm
      t.string :s_bt
      t.string :s_no, null: false
      t.string :s_df_flag
      t.string :s_sg_no
      t.string :s_cid

      t.timestamps
    end
  end
end
