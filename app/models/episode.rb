class Episode < ApplicationRecord
  
  attr_accessor :this_challenge_id
  
  has_one_attached :clip
  has_one_attached :images
  
  belongs_to :challenge
  validates :content, presence: true, length: {maximum: 255 }
  validates :variation, presence: true, length: { maximum: 160 }
  # 画像/動画投稿時のバリデーション対応のため。↓
  validate :validate_image
  validate :validate_clip
  
  # 画像/動画投稿時のバリデーション対応のため。↓
    def validate_image
      return unless images.attached? 
      if images.blob.byte_size > 10.megabytes
        images.purge 
        errors.add(:images, '投稿可能な画像サイズは10MBまでです')
      elsif !image?
        images.purge
        errors.add(:images, '投稿可能な画像データは「jpg、jpeg、gif、png」です。')
      end
    end
    
    def validate_clip
      return unless clip.attached? 
      if clip.blob.byte_size > 512.megabytes
        clip.purge 
        errors.add(:clip, '投稿可能な動画サイズは512MBまでです')
      elsif !video?
        clip.purge
        errors.add(:clip, '投稿可能な動画データは「mp4、mov、qt」です。')
      end
    end
    
    private

    def image?
      %w[image/jpg image/jpeg image/gif image/png].include?(images.blob.content_type)
    end
    
    def video?
      %w[video/mp4 video/quicktime].include?(clip.blob.content_type)
    end
    
end