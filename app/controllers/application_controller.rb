class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # リスト8.13 セッション用ヘルパーを読み込ませる
  include SessionsHelper

  def hello
    render html: "hello, world!"
  end
end
