Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :admin do
    root to: "users#index"
    resources :users, only: [:show, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    # ゲストログイン用ルーティング
    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    resources :users, only: [:show, :edit, :update] do
      collection do
        get :confirm
        patch :withdraw
      end
      resource :relationships, only:[:create, :destroy] do
        collection do
          get :followings
          get :followers
        end
      end
      resource :follow_requests, only:[:create, :destroy] do
        member do
          post :allow
          delete :reject
          get :index
        end
      end
    end
    resources :chatters, only: [:show, :destroy, :create] do
      resource :chatter_favorites, only: [:create, :destroy]
      member do
        get :favorite_users
        get :rechatter_users
      end
      resource :rechatters, only: [:create, :destroy]
      collection do
        post :reply
        get :update_tl
      end
    end
    resources :works, only: [:create, :show, :destroy, :update] do
      resource :work_favorites, only: [:create, :destroy]
      member do
        get :favorite_users
        patch :update_tags # タグのみ編集用route
      end
      collection do
        get :update_tl
      end
      resources :comments, only: [:create, :destroy]
      resources :follow_tags, only: [:create, :destroy] # work#showでの個別タグフォロー/解除
    end
    resources :notifications, only: [:index] do
      post :update_checked, on: :collection
    end
    get 'search' => 'searches#search'
    get 'tag_link_search' => 'works#tag_link_search' # work#showのタグリンクからのWorkTag検索
    patch 'follow_tags' => 'follow_tags#follow_tags' # homes#topでのフォロータグ設定
    get 'error' => 'homes#error'
    get 'about' => 'homes#about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
