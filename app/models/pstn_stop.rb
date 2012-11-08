class PstnStop < ActiveRecord::Base
  attr_accessible :sn, :status, :user_id ,:work_order_t,:emerg
  belongs_to :user
end
