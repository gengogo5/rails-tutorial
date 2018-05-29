require 'rails_helper'

module TestHelper

  # テストユーザがログイン中の場合にtrueを返す
  # TODO これをfeatureスペックから呼び出せない
  # リスト8.27で使ってるけど、:integrationテストでは・・・？
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザとしてログインする
  # 10章で使うらしい
  #def log_in_as(user)
  #  session[:user_id] = user.id
  #end

  # テストユーザとしてログインする
  # capybaraでログインする用
  # こういうヘルパーを作ることが適切なのかは疑問
  def log_in_as(user, password: 'password', remember_me: '1')
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: password
    check 'ログイン状態を記憶する' if remember_me == '1'
    within ".row" do
      click_on 'ログイン'
    end
  end
end
