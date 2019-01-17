class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :message
  
  validates :title, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 800 }
end
