class User < ApplicationRecord
  has_many :bubbles

  has_secure_password validations: false
  validates :password, presence: {message: 'Поле не может быть пустым'},
                       length: {minimum: 5, message: 'Пароль слишком легкий'},
                       confirmation: false
  validates :username, presence: {message: 'Поле не может быть пустым'},
                       length: { minimum: 3, message: 'Имя пользователя должно быть не короче 3-х символов' },
                       format: {
                         with: /\A[\da-zA-Z_]+\z/,
                         message: 'Имя пользователя должно состоять только из латинских букв, цифр и нижних подчеркиваний'
                       },
                       uniqueness: { message: 'Имя пользователя занято' }
  validates :email, presence: {message: 'Поле не может быть пустым'},
                    format: { with: /\A[^@;"\s]+@[^@;"\s]+\.[^@;"\s]+\z/, message: 'Неверный формат почты' },
                    uniqueness: { message: 'Почта занята другим пользователем' }
  before_save { username.downcase! }
  before_save { email.downcase! }

  def self.find_by_login(login)
    /\A[^@;"\s]+@[^@;"\s]+\.[^@;"\s]+\z/.match?(login) ? find_by_email(login) : find_by_username(login)
  end
end
