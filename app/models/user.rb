class User < ApplicationRecord
  attr_accessor :remember_token
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
  # User.digest, self.digest, class << self def digest の3通リの書き方がある
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションの為にユーザをデータベースに記憶する
  def remember
    # selfを書かないとローカル変数になってしまう
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # ここのremember_tokenはローカル変数
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
