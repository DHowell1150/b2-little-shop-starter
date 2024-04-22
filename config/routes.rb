Rails.application.routes.draw do
  root "welcome#index"
  
  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :coupons, only: [:index, :show, :new, :create], :controller => 'merchant_coupons'
    resources :items, except: [:destroy]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end
end
