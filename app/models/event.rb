class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 800 }
  validates :deadline, presence: true
  mount_uploader :image, ImageUploader
  
  has_many :participate
  has_many :participate_user, through: :participate, source: :user
end
