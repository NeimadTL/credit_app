Rails.application.routes.draw do


  devise_for :users, controllers: { registrations: "customised_registrations" }
  root 'welcome#index'


end
