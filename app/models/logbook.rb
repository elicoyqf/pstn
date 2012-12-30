class Logbook < ActiveRecord::Base
  attr_accessible :content, :user_id, :log_type
  belongs_to :user
end
