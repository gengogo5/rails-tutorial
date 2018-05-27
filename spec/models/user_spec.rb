require 'rails_helper'

#TODO Context,letを使う書き方
# describeを綺麗に入れ子にしたら見やすいはず
RSpec.describe User, type: :model do

  let(:user) { User.new(name: "Example User", email: "user@example.com",
             password: "foobar", password_confirmation: "foobar") }

  it "nameとemailを持つユーザが有効であること" do
    expect(user).to be_valid
  end

  it "nameがないユーザは無効であること" do
    user.name = "     "
    expect(user).not_to be_valid
  end

  it "emailがないユーザは無効であること" do
    user.email = "     "
    # エラーメッセージで検証する方法
    # 学習目的で書いたものの、壊れやすいので採用するかは微妙
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "nameが最大長を越えたら無効になること" do
    user.name = "a" * 51
    expect(user).not_to be_valid
  end

  it "emailが最大長を越えたら無効になること" do
    user.email = "a" * 244 + "@example.com"
    expect(user).not_to be_valid
  end

  it "emailの有効パターンの確認" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "emailの無効パターンの確認" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end
  end

  it "emailが重複したユーザが無効になること" do
    duplicate_user = user.dup
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it "emailが大文字小文字を区別しないこと" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it "emailが小文字で保存されること" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it "パスワードがないユーザは無効であること" do
    user.password = user.password_confirmation = " " * 6
    expect(user).not_to be_valid
  end

  it "パスワードが最短未満のユーザは無効であること" do
    user.password = user.password_confirmation = "a" * 5
    expect(user).not_to be_valid
  end
end
