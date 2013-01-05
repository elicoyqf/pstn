class JfName < ActiveRecord::Base
  attr_accessible :ip_address, :name, :status, :p_emerg, :p_int, :p_local, :p_nat, :p_suburban
  has_many :dn_tables
end
