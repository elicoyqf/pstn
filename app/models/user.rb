class User < ActiveRecord::Base
  attr_accessible :name, :password, :level,:department_id,:alias_name
  has_many :pstn_stops
  has_many :work_orders
  has_many :logbooks
  has_many :events
  has_many :cfwd_regs
  belongs_to :department
end
