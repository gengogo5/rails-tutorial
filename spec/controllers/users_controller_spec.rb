require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "レスポンスがSUCCESSであること" do
      visit signup_path
      expect(response).to have_http_status(:success)
    end
  end

end
