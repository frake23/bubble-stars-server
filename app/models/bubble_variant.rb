class BubbleVariant < ApplicationRecord
  belongs_to :bubble
  has_one_attached :image

  validates :name, presence: {message: 'Поле не может быть пустым'}
  validate :image_validation

  def image_validation
    return errors.add(:image, 'Необходимо изображение') unless image.attached?

    errors.add(:image, 'Неверный формат') unless image.blob.content_type.starts_with?('image/')
  end

  def cdn_image
    image.url.sub(ENV['STORAGE_ENDPOINT'], ENV['CDN_ENDPOINT'])
  end
end
