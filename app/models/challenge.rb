class Challenge < ApplicationRecord
  belongs_to :user
  validates :challenge, presence: true, length: {maximum: 255 }
  validates :goal, length: { maximum: 255 }
end
