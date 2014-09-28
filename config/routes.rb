Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  root to: "home#index"
  resources :users, only: [:index, :edit, :update]
  resources :patients, except: :destroy do
    resources :clinical_histories, only: [:new, :create]
    resources :specimens, only: [:new, :create]
  end
  get '/search', to: "searches#new"
end
