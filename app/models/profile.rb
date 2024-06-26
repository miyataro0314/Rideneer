class Profile < ApplicationRecord
  validates :user_id, uniqueness: true
  validates :user_name, presence: true

  has_one_attached :avatar
  has_one_attached :vehicle_photo
  belongs_to :user

  enum vehicle_type: { big: 0, regular: 5, small: 10, moped: 15 }

  def convert_images
    return if !avatar.attached? && !vehicle_photo.attached?

    ConvertToJpegJob.perform_later(self, :avatar) if avatar.attached?
    ConvertToJpegJob.perform_later(self, :vehicle_photo) if vehicle_photo.attached?
  end
end
