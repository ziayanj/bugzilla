Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects do
    resources :bugs do
      member do
        get 'assign'
        get 'resolve'
      end
    end
    member do
      get 'add_user'
      get 'remove_user'
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
