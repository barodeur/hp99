Hp99::Application.routes.draw do
  root :to => 'registrations#new'
  resources :registrations, :only => [:show, :new, :create], :path => 'r'
end
