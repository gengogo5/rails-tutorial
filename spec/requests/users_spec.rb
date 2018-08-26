require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET #new" do
    it "レスポンスがSUCCESSであること" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  context "ログインせずにusers_pathにアクセスした場合" do
    it "login_pathにリダイレクトされること" do
      get users_path
      expect(response).to redirect_to login_path
    end
  end

  context "ログインせずにedit画面に遷移した場合" do
    let(:user) { create(:michael) }

    it "login_pathにリダイレクトされること" do
      get edit_user_path(user)
      expect(flash[:danger]).not_to be_empty
      expect(response).to redirect_to login_path
    end
  end

  context "ログインせずにupdateしようとした場合" do
    let(:user) { create(:michael) }

    it "login_pathにリダイレクトされること" do

      patch user_path(user), params: { user: { name: user.name, email: user.email }}
      expect(flash[:danger]).not_to be_empty
      expect(response).to redirect_to login_path
    end
  end

  context "間違ったユーザでログインしてeditしようとした場合" do
    let(:user) { create(:michael) }
    let(:other_user) { create(:archer) }

    it "root_pathにリダイレクトされること" do
      login_as(other_user)
      get edit_user_path(user)

      expect(flash[:danger]).to be_nil
      expect(response).to redirect_to root_path
    end
  end

  context "間違ったユーザログインしてupdateしようとした場合" do
    let(:user) { create(:michael) }
    let(:other_user) { create(:archer) }

    it "root_pathにリダイレクトされること" do
      login_as(other_user)
      patch user_path(user), params: { user: { name: user.name, email: user.email }}

      expect(flash[:danger]).to be_nil
      expect(response).to redirect_to root_path
    end
  end
end
