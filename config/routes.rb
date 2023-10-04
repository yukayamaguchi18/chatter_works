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
    end
    resources :chatters, only: [:show, :new, :destroy, :create] do
      resource :chatter_favorites, only: [:index, :create, :destroy]
      resource :rechatters, only: [:index, :create, :destroy]
      resources :replies, only: [:create, :destroy]
    end
    resources :works, only: [:new, :create, :show] do
      resource :work_favorites, only: [:create, :destroy, :index]
      resources :work_tags, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get 'search' => 'searches#search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
