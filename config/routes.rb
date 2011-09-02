Hp99::Application.routes.draw do
  root :to => 'registrations#new'

  devise_for :admins

  namespace :admin do
  end

  resources :registrations, :only => [:show, :new, :create], :path => 'r' do
    get :confirmation, :on => :member
    get :unconfirm, :on => :member
  end
end
