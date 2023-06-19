class Event < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :attendances
  has_many :attendees, through: :attendances
  scope :past, -> { where 'date < ?', DateTime.now }
  scope :upcoming, -> { where 'date >= ?', DateTime.now }
end
