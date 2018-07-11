module SessionsHelper

  # 渡されたユーザでログインする
  def log_in(user)
    # sessionメソッド(作成された一時cookiesはブラウザを閉じると消える)
    # ブラウザ内の一時cookiesに暗号化済ユーザIDが作成される
    # 一時cookiesのユーザIDは別ページで取り出せる
    session[:user_id] = user.id
  end

  # ユーザのセッションを永続的にする
  def remember(user)
    user.remember
    # cookies.permanentで永続クッキーを作成
    # signedで暗号化
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 渡されたユーザがログイン済みユーザであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # 現在ログイン中のユーザを返す(いる場合)
  def current_user
    # @current_userがnilなら右辺を実行、非nilなら@current_userを返す
    # 上記は無駄なデータベースアクセスを毎回行わない為のテクニック
    # User.findは、引数idがnilだと例外となるが、User.find_byならユーザが存在しない場合はnilが返る
    if (user_id = session[:user_id]) # 一時cookiesが存在する場合
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id]) # 永続cookiesが存在する場合
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザがログインしていればtrue, その他ならfalseを返す
  # viewでユーザのログイン判定をする為に必要
  def logged_in?
    # current_userの返却値がnilでない = current_userが存在する ならtrue
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したURL
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを記憶
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
