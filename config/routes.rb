Rails.application.routes.draw do
  # ユーザー用
  # URL /users/sign_in...
  devise_for :users, controllers: {
    # devise_for :users
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    # devise_for :admins
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
