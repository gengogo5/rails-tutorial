require 'rails_helper'

#TODO
#assert_select以外に適切な書き方は無い？expect使うやつ

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

  describe "GET #home" do
    render_views

    # これぐらいならbeforeでやらなくてもいいかもしれない？
    before do
      get :home
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to have_http_status(:success)
    end

    it "titleに期待した文字列が表示されること" do
      assert_select "title", "#{base_title}"
    end
  end

  describe "GET #help" do
    render_views

    before do
      get :help
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to have_http_status(:success)
    end

    it "titleに期待した文字列が表示されること" do
      assert_select "title", "Help | #{base_title}"
    end
  end

  describe "GET #about" do
    render_views

    before do
      get :about
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to have_http_status(:success)
    end

    it "titleに期待した文字列が表示されること" do
      assert_select "title", "About | #{base_title}"
    end
  end

  describe "GET #contact" do
    render_views

    before do
      get :contact
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to have_http_status(:success)
    end

    it "titleに期待した文字列が表示されること" do
      assert_select "title", "Contact | #{base_title}"
    end
  end
end
