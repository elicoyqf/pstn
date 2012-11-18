class User < ActiveRecord::Base
  attr_accessible :name, :password ,:level
  has_many :pstn_stops
  has_many :work_orders
end
