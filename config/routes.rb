Qrey::Application.routes.draw do
  resources :qr_codes
  resources :admin, :only => [:index]
  root :to => 'qr_codes#index'
end
