require 'rails_helper'

RSpec.feature "ユーザ情報更新", type: :feature do

  let(:user) { create(:michael) }

  scenario "更新失敗" do
    log_in_as(user)
    visit edit_user_path(user)

    expect(page).to have_current_path edit_user_path(user)

    fill_in :user_name , with: ""
    fill_in :user_email, with: "foo@invalid"
    fill_in :user_password, with: "foo"
    fill_in :user_password_confirmation, with: "bar"

    click_on '更新する'

    # TODO ユーザページに遷移してないことの確認
    expect(page).to have_selector "div#error_explanation"
    # TODO エラーメッセージでアサーションはあまりしたくない・・・
    expect(page).to have_selector "div.alert", text: '4 個の入力エラーがあります。'
  end

  scenario "更新成功" do
    log_in_as(user)
    visit edit_user_path(user)

    expect(page).to have_current_path edit_user_path(user)

    name = "Foo Bar"
    email = "foo@bar.com"

    fill_in :user_name , with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: ""
    fill_in :user_password_confirmation, with: ""

    click_on '更新する'

    # エラーメッセージがないこと
    expect(page).not_to have_selector "div#error_explanation"

    user.reload
    expect(user.name).to eq name
    expect(user.email).to eq email

  end

  scenario "フレンドリーフォワーディングされること" do
    visit edit_user_path(user)
    expect(page).to have_current_path login_path

    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    within ".row" do
      click_on 'ログイン'
    end
    expect(page).to have_current_path edit_user_path(user)

    name = "Foo Bar"
    email = "foo@bar.com"

    fill_in :user_name , with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: ""
    fill_in :user_password_confirmation, with: ""

    click_on '更新する'

    user.reload
    expect(user.name).to eq name
    expect(user.email).to eq email
  end

end
