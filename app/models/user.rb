class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: {maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    validates :profile, length: { maximum: 160 }
    has_secure_password
    has_one_attached :avatar
    has_many :challenges, inverse_of: :user, dependent: :destroy
    has_many :relationships,dependent: :destroy
    has_many :influences, through: :relationships, source: :influence
    has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: 'influence_id',dependent: :destroy
    has_many :influencers, through: :reverses_of_relationship, source: :user
    
    def influence(other_user)
      unless self == other_user
        self.relationships.find_or_create_by(influence_id: other_user.id)
      end
    end
    
    def uninfluence(other_user)
      relationship = self.relationships.find_by(influence_id: other_user.id)
      relationship.destroy if relationship
    end
    
    def influencing?(other_user)
      self.influences.include?(other_user)
    end
end
