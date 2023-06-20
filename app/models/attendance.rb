class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :event
  scope :user_event, ->(user_id, event_id) { select('id').where('attendee_id = ? AND event_id = ?',
                                                                user_id, event_id)}
end
