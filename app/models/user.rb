class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, foreign_key: :host_id
  has_many :attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :attendances, source: :event

  def peers
    User.all - [self]
  end
end
