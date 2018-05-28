FactoryBot.define do
  factory :michael, class: User do
    name 'Michael Example'
    email 'michael@example.com'
    # fixutureではERbを使用してdigestを作ってた
    password 'password'
    password_confirmation 'password' # 無くても動いた
  end
end
