Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about", as: :about

  resources :products, only: :show do
    collection { get :search }
  end
  resources :categories, only: :show

  get "cart", to: "cart#show", as: :cart
  post "cart/items", to: "cart#add", as: :cart_items

  get "checkout", to: "checkout#new", as: :new_checkout
  post "checkout", to: "checkout#create", as: :checkout
  get "orders/:order_number", to: "checkout#confirmation", as: :order_confirmation

  namespace :admin do
    resource :session, only: %i[new create destroy], path: "login"
    resources :products, except: :show
    resources :categories, except: :show
  end
end
