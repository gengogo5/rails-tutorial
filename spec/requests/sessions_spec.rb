require 'rails_helper'

# ネーミングが悩ましい
RSpec.describe "Sessions", type: :request do
  describe "GET login_path" do
    it "レスポンスがSUCCESSであること" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
