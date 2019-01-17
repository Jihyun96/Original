class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :campus,:department, presence: true
  has_secure_password
  
  mount_uploader :image, ImageUploader
  has_many :message
  has_many :comment
  has_many :event
  
  has_many :participate
  has_many :participate_event, through: :participate, source: :event
  
  def like(event)
    unless self == event.user
      self.participate.find_or_create_by(event_id: event.id)
    end
  end

  def unlike(event)
    participate = self.participate.find_by(event_id: event.id)
    participate.destroy if participate
  end

  def bookmarking?(event)
    self.participate_event.include?(event)
  end
end
