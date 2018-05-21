class User < ApplicationRecord
  # オブジェクト保存前に実行される
  before_save { email.downcase! }
  # バリデーション設定
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  # password利用
  has_secure_password
  validates :password, presence: true, length: { minimum:6 }
end
