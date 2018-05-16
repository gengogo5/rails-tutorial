Rails.application.routes.draw do
  #パスとコントローラ#アクションの違いを意識すること
  root 'static_pages#home'

  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  get 'static_pages/contact'
end
