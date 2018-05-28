module SessionsHelper

  # 渡されたユーザでログインする
  def log_in(user)
    # sessionメソッド(作成された一時cookiesはブラウザを閉じると消える)
    # ブラウザ内の一時cookiesに暗号化済ユーザIDが作成される
    # 一時cookiesのユーザIDは別ページで取り出せる
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザを返す(いる場合)
  def current_user
    # @current_userがnilなら右辺を実行、非nilなら@current_userを返す
    # 上記は無駄なデータベースアクセスを毎回行わない為のテクニック
    # User.findは、引数idがnilだと例外となるが、User.find_byならユーザが存在しない場合はnilが返る
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザがログインしていればtrue, その他ならfalseを返す
  # viewでユーザのログイン判定をする為に必要
  def logged_in?
    # current_userの返却値がnilでない = current_userが存在する ならtrue
    !current_user.nil?
  end

  # 現在のユーザをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
