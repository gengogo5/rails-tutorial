class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # user_paramsメソッドでnewに渡すパラメータを制限する方式
    # Strong Parameters
    @user = User.new(user_params)
    if @user.save
      # ユーザ作成時に自動的にログインする
      log_in @user
      flash[:success] = "hogetterへようこそ!"
      # 下記は次と等価 redirect_to user_url(@user)
      redirect_to @user
    else
      # エラー時はUserモデルのエラーメッセージが表示される
      render 'new'
    end
  end

  private
    # params全体を初期化して使用するのは危険な為、
    # 適切なプロパティのみを初期化対象としたハッシュを返す
    def user_params
      # httpリクエストのパラメータから、
      # 許可したキーのみを持つハッシュであること
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
