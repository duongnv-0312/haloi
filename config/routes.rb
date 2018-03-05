Rails.application.routes.draw do
  root "products#index"

  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users
end
