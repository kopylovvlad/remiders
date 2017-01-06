Rails.application.routes.draw do
  devise_for :user, controllers: {
    registrations: 'user/registrations'
  }
  root to: "home#index"

  resources :item_lists do
    resources :items
  end

  get '*unmatched_route', to: 'application#render_not_found'
  get '/500', to: 'application#render_error'
end
