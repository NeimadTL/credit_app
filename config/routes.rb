Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: "customised_registrations" }
  root 'welcome#index'

  namespace :client do
    resources :bank_accounts, only: [:index, :new, :create]
  end


end
