Rails.application.routes.draw do

  root 'home#index'

  resources :companies do
    resources :projects
  end

  devise_for :users

end
