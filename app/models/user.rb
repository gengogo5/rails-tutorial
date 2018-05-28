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

  # 渡された文字列のハッシュ値を返す
  # リスト 8.21で作ったが、fixtureじゃなくてfactoryBot使う場合は不要っぽい
  #def User.digest(string)
  #  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                            BCrypt::Engine.cost
  #  BCrypt::Password.create(string, cost: cost)
  #end
end
