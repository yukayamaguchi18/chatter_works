Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'searches/index'
  end
  namespace :public do
    get 'work_favorites/index'
  end
  namespace :public do
    get 'works/new'
    get 'works/show'
  end
  namespace :public do
    get 'rechatters/index'
  end
  namespace :public do
    get 'chatter_favorites/index'
  end
  namespace :public do
    get 'chatters/show'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'homes/top'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
