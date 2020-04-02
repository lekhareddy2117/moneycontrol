Rails.application.routes.draw do
  get 'home/index'
  namespace :api do
    namespace :v1 do
      get 'companies/data/', to: 'companies#save_data'
      get 'companies/chart/', to: 'companies#chart'
      get 'companies/details/', to: 'companies#companydetails'
      resources :companies do
       
      resources :stocks
      
      end
    end
  end
  resources :companies
  
  
  default_url_options :host => "localhost"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
