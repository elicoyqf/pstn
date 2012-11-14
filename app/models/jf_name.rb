class JfName < ActiveRecord::Base
  attr_accessible :ip_address, :name ,:status
  has_many :dn_tables
end
