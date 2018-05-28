class SessionsController < ApplicationController

  # GET /login
  def new
  end

  # POST /login
  def create
    # 入力されたメールアドレスがsessionに格納されている
    # メールアドレスでユーザを検索し、パスワードで認証する
    # paramsハッシュの中にsessionハッシュがある
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン後にユーザ情報ページへリダイレクト
      log_in user
      # user_url(user)に変換されてユーザのプロフィールへリダイレクトされる
      redirect_to user
    else
      # Active Recordのモデルを使っていない為、
      # ユーザ登録のようにエラーメッセージが表示できない
      # 代替手段としてflashを使う
      flash.now[:danger] = 'メールアドレスかパスワードが誤っています'
      render 'new'
    end
  end

  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url
  end
end
