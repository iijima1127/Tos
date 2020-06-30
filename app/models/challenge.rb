class Challenge < ApplicationRecord
  belongs_to :user
  validates :challenge, presence: true, length: {maximum: 255 }
  validates :goal, length: { maximum: 255 }
  has_many :episodes, inverse_of: :challenge
end
