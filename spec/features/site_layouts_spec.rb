require 'rails_helper'

#capybaraのテストではこう書ける
#TODO scenarioの区切り方がイマイチかもしれない
feature "サイトレイアウトの確認" do
  # beforeはbackgroundに
  background do
  end

  let(:user){ create(:michael) }

  # itはscenarioに
  scenario "リンクの確認" do
    # root_pathは'/'を返すメソッド
    visit root_path

    # visitのレスポンス(HTML)はpageメソッドで受けられる
    # page に to 以下の性質をexpectする
    # TODO 当該ページがhomeのテンプレートで描画されていることの確認方法
    #expect(page).to render_template :home

    # root_pathが2ヶ所にあることを確認する
    # リンク名指定も可だが、壊れやすい&チュートリアルに従う為countにする
    #expect(page).to have_link 'hogetter', href: root_path
    #expect(page).to have_link 'Home', href: root_path
    expect(page).to have_link href: root_path, count: 2

    # それぞれのpathが存在することを確認
    expect(page).to have_link  href: help_path
    expect(page).to have_link  href: about_path
    expect(page).to have_link  href: contact_path

    # リスト 5.36 titleの確認
    visit contact_path
    expect(page).to have_title full_title("Contact")

    # 演習5.4.2
    visit signup_path
    expect(page).to have_title full_title("Sign up")
  end

  scenario "ログイン後のリンクの確認" do

    log_in_as(user)
    expect(page).to have_link  href: users_path
    expect(page).to have_link  href: user_path(user)
    expect(page).to have_link  href: edit_user_path(user)
    expect(page).to have_link  href: logout_path
  end

end

