class Department < ActiveRecord::Base
  attr_accessible :f_node, :name
  has_many :users
end
