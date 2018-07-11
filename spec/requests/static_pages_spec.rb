require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "GET root" do
    it "レスポンスがSUCCESSであること" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #help" do

    before do
      get help_path
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to be_success
    end

    it "レスポンスのtitleに期待した文字列が含まれること" do
      expect(response.body).to include "Help | #{base_title}"
    end
  end

  describe "GET #about" do

    before do
      get about_path
    end

    it "レスポンスが200であること" do
      expect(response).to have_http_status "200"
    end

    it "レスポンスのtitleに期待した文字列が含まれること" do
      expect(response.body).to include "About | #{base_title}"
    end
  end

  describe "GET #contact" do

    before do
      get contact_path
    end

    it "レスポンスがSUCCESSであること" do
      expect(response).to have_http_status(:success)
    end

    it "レスポンスのtitleに期待した文字列が含まれること" do
      expect(response.body).to include "Contact | #{base_title}"
    end
  end
end
