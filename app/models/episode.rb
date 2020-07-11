class Episode < ApplicationRecord
  
  attr_accessor :this_challenge_id
  
  has_one_attached :clip
  has_one_attached :images
  
  belongs_to :challenge
  validates :content, presence: true, length: {maximum: 255 }
  validates :variation, presence: true, length: { maximum: 160 }
end