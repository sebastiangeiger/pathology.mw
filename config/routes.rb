Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  root to: "home#index"
  resources :users, only: [:index, :edit, :update]
  resources :physicians, only: [:new, :create]
  resources :patients, except: :destroy do
    resources :clinical_histories, only: [:new, :create]
    resources :specimens, except: [:destory, :show, :index]
  end
end
