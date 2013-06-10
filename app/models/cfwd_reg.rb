#encoding : utf-8
class CfwdReg < ActiveRecord::Base
  attr_accessible :cf_type, :mobile, :user_id, :c_date
  belongs_to :user

  validates :mobile, numericality: { message: '呼转号码存在非数字输入，请检查!' }
  validates :mobile, length: { minimum: 7, maximum: 15, message: '呼转号码最少要7位，最大为15，输入有误，请检查!' }
end
