class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :event_type, :user_id, :update_id
  has_event_calendar
  belongs_to :user
  belongs_to :update_user,:class_name => 'User',:foreign_key => 'update_id'
  #belongs_to :updateuser,:class_name => 'User'
end
