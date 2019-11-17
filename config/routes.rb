Rails.application.routes.draw do
  root "products#index"

  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :shop do
    resources :products
  end

  resources :products
end
