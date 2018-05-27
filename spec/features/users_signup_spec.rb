require 'rails_helper'

RSpec.feature "UsersSignup", type: :feature do

  scenario "無効なユーザ登録" do
    visit signup_path

    # fill_in には :id or ラベル or id[要素]の指定方法がある
    fill_in :user_name, with: ''
    fill_in 'メールアドレス', with: 'user@invalid'
    fill_in 'user[password]', with: 'foo'
    fill_in 'パスワード確認', with: 'bar'

    # チュートリアルではPOSTを使っているが、
    # 画面を叩くシナリオで実装してみる
    expect { click_on '登録する' }.not_to change { User.count }

    # TODO assert_templateの代用
    expect(page).to have_selector 'div#error_explanation'
    expect(page).to have_selector 'div.alert'

    # 7.3.4 演習4
    expect(page).to have_selector 'form[action="/signup"]'
  end

  scenario "有効なユーザ登録" do
    visit signup_path

    fill_in :user_name,   with: "Example User"
    fill_in :user_email,  with: "user@example.com"
    fill_in :user_password, with: "password"
    fill_in :user_password_confirmation, with: "password"

    expect { click_on '登録する' }.to change { User.count }.by(+1)

    # TODO users/showテンプレートであることを確認したい
    # 7.34 flashのテスト
    # TODO flash[:success]を取得する方法
    expect(page).not_to have_selector 'div#error_explanation'
    expect(page).to have_selector 'div.alert', count: 1
  end
end
