require 'rails_helper'

module TestHelper

  # テストユーザがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end
end
