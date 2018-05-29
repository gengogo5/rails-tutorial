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

    # 2番目のウインドウでログアウトをクリックするケースをシミュレート
    page.driver.submit :delete, logout_path, {}

    expect(page).to have_current_path root_path
    expect(page).to have_link href: login_path
    expect(page).not_to have_link href: logout_path
    expect(page).not_to have_link href: user_path(user)
  end

  # リスト 9.25 ではログインをhelperに外出ししているので、
  # とりあえずcapybara的な記述に直している
  # 実際のところ何やってるかわかりづらいので、べた書きしたほうがいいのかも
  scenario "remember_meでログイン" do
    # 中でvisitとかfill_in, click_onをやっている
    log_in_as(user, remember_me: '1')
    # cookiesを直接使えなかったのでこれで対応
    # あっているか自信なし…
    cookie_value = page.driver.browser.rack_mock_session.cookie_jar['remember_token']
    expect(cookie_value).not_to be_blank
  end

  scenario "remember_meをつけずにログイン" do
    # クッキーを保存してログイン
    log_in_as(user, remember_me: '1')
    cookie_value_with_remember_me = page.driver.browser.rack_mock_session.cookie_jar['remember_token']
    expect(cookie_value_with_remember_me).not_to be_blank

    click_on 'ログアウト'

    # クッキーを削除してログイン
    log_in_as(user, remember_me: '0')

    cookie_value_without_remember_me = page.driver.browser.rack_mock_session.cookie_jar['remember_token']
    expect(cookie_value_without_remember_me).to be_blank
  end
end
