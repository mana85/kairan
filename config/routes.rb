Rails.application.routes.draw do
  # devise
  # ユーザー用
  # URL /users/sign_in...
  devise_for :users, controllers: {
    # devise_for :users
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    # devise_for :admins
    sessions: "admin/sessions"
  }

  # ゲストユーザー
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # devise　以外
  # ユーザー側
  scope module: :public do
    # ホーム
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    # ユーザー
    get "users/my_page" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "users/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    patch "users/withdrawal" => "users#withdrawal", as: "withdrawal"
    resources :users, only: [:show]
    # Flyer *告知・タグ
    resources :flyers, only: [:index, :show, :new, :edit, :create, :destroy, :update] do
      resources :comments, only: [:create, :destroy]
      resource :clips, only: [:create, :destroy]
    end
    get "search_word" => "flyers#search_word"
    get "flyer/clipedflyer" => "flyers#clipedflyer", as: "clipedflyer"
    get "flyer/myflyer" => "flyers#myflyer", as: "myflyer"
    get "flyer/tag/:id" => "flyers#tag", as: "tag"
  end
  # 管理者用
  namespace :admin do
    # ホーム
    root to: "homes#top"
    # ユーザー
    resources :users, only: [:index, :show, :edit, :update]
    # フライヤー
    resources :flyers, only: [:index, :show, :edit, :update]
    # コメント
    resources :comments, only: [:index, :show, :edit, :update]
  end
end
