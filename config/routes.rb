Rails.application.routes.draw do

  resources :companies do
    resources :projects
  end

  devise_for :users
  root 'home#index'

end
