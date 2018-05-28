require 'rails_helper'

RSpec.feature "UsersLogin", type: :feature do

  # buildだとテストユーザが保存されないのでログイン不可
  # createを使うべし
  # givenはletのエイリアス
  given(:user) { create(:michael) }

  scenario "無効なログイン" do
    visit login_path
    # これは意味ないかも
    expect(page).to have_current_path login_path

    fill_in 'メールアドレス', with: ""
    fill_in 'パスワード', with: ""

    # エラーメッセージが表示されること
    # 'ログイン'が複数箇所に存在する為、withinで絞り込む
    within '.row' do
      click_on 'ログイン'
    end
    expect(page).to have_selector 'div.alert-danger'

    # 別ページに遷移した際にエラーメッセージが表示されないこと
    visit root_path
    expect(page).not_to have_selector 'div.alert-danger'
  end

  scenario "有効なログイン" do
    visit login_path

    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'

    within '.row' do
      click_on 'ログイン'
    end

    # ログインされたことを確認
    # idを1固定にしてるのは大丈夫か？
    expect(page).to have_current_path '/users/1'
    expect(page).not_to have_link href: login_path
    expect(page).to have_link href: logout_path
    expect(page).to have_link href: user_path(user)
  end

  scenario "ログイン後にログアウトする" do
    visit login_path

    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'

    within '.row' do
      click_on 'ログイン'
    end

    # TODO is_logged_in? でセッション情報の確認
    expect(page).to have_current_path '/users/1'
    expect(page).not_to have_link href: login_path
    expect(page).to have_link href: logout_path
    expect(page).to have_link href: user_path(user)

    click_on 'ログアウト'

    expect(page).to have_current_path root_path
    expect(page).to have_link href: login_path
    expect(page).not_to have_link href: logout_path
    expect(page).not_to have_link href: user_path(user)

  end
end
