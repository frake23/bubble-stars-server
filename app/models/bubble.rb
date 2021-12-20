class Bubble < ApplicationRecord
  belongs_to :user
  has_many :bubble_variants

  validates :title, presence: { message: 'Поле не может быть пустым' }
  validates :description, presence: { message: 'Поле не может быть пустым' }
end
