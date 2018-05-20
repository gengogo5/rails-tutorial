require 'rails_helper'

# 疑問
# Integration testでないのにCapybaraを使うのは適切なのか？
# titleの表示を確認するのはフィーチャースペックではない？
# get :helpと visit help_pathの違いってなんだ
RSpec.describe StaticPagesController, type: :controller do

  # beforeでインスタンス変数を作る方法もある
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "GET root" do
    render_views

    it "レスポンスがSUCCESSであること" do
      visit root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #help" do
    render_views

    before do
      visit help_path
    end

    it "レスポンスがSUCCESSであること" do
      # 複数の実装方法を知るために書き方を統一していない
      expect(response).to be_success
    end

    it "titleに期待した文字列が表示されること" do
      expect(page).to have_title "Help | #{base_title}"
    end
  end

  describe "GET #about" do
    render_views

    before do
      visit about_path
    end

    it "レスポンスが200であること" do
      expect(response).to have_http_status "200"
    end

    it "titleに期待した文字列が表示されること" do
      expect(page).to have_title "About | #{base_title}"
    end
  end

  describe "GET #contact" do
    render_views

    before do
      visit contact_path
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to have_http_status(:success)
    end

    it "titleに期待した文字列が表示されること" do
      expect(page).to have_title "Contact | #{base_title}"
    end
  end
end
