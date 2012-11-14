class DnTable < ActiveRecord::Base
  attr_accessible :dn_end, :dn_start, :jf_name_id
  belongs_to :jf_name
end
