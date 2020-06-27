class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: {maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    validates :profile, length: { maximum: 160 }
    has_secure_password
    has_one_attached :avatar
    has_many :challenges
end
