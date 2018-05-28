Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  # パスとコントローラ#アクションの違いを意識すること
  # ルートURLを定義するとroot_pathやroot_urlなどのメソッドが使えるようになる
  # xxx_path -> '/xxx'
  # xxx_url -> 'http://www.example.com/xxx'
  root 'static_pages#home'

  # /helpにリクエストが来たら、StaticPagesコントローラのhelpアクションを呼び出す
  get '/help', to: 'static_pages#help'

  # 古い例としてコメントで残す
  # get 'static_pages/about'
  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # sessionリソースはresourcesでフルセットのルーティングを作成する必要なし
  get '/login',   to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Usersリソースにアクションと名前付きルートを提供する
  resources :users
end
