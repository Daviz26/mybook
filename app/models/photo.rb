class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

   private

    def picture_size
      if picture.size > 5.megabytes
         errors.add(:picture, "should be less than 5MB")
      end
    end
    
end
