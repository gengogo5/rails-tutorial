require 'rails_helper'

describe SessionsHelper do
  let(:user) do
    create(:michael)
  end

  context "セッションがnilの場合" do
    it "current_userが正しいuserを返すこと" do
      remember(user)
      expect(current_user).to eq user
      expect(is_logged_in?).to be true
    end
  end

  context "rememberダイジェストが誤っている場合" do
    it "current_userがnilを返すこと" do
      remember(user)
      # rememberの後に新しいダイジェストでremember_digestを上書きする
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be_nil
    end
  end
end
