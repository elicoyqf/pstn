class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :event_type, :user_id
  has_event_calendar
  belongs_to :user
end
