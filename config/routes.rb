Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects do
    resources :bugs
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
