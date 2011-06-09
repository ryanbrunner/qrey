Qrey::Application.routes.draw do
  resources :qr_codes, :only => [:index, :new, :create, :show]

  root :to => 'qr_codes#index'
end
