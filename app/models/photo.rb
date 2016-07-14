class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  
  has_many :comments, dependent: :destroy
  acts_as_votable

   private

    def picture_size
      if picture.size > 5.megabytes
         errors.add(:picture, "should be less than 5MB")
      end
    end
    
end
