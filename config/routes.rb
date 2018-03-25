Rails.application.routes.draw do
  root "products#index"

  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users

  namespace :shop do
    resources :products
  end
end
