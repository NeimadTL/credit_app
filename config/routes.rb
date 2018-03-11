Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: "customised_registrations" }
  root 'welcome#index'

  namespace :client do
    resources :bank_accounts, only: [:index, :new, :create, :show]
  end

  namespace :admin do
    resources :transactions, only: [:index, :new, :create]
    resources :users, only: [:index, :edit, :update, :destroy]
  end

end
