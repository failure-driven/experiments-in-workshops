Rails.application.routes.draw do
  resources :messages
  resources :entries
  namespace :guestbook_with_ai do
    resources :entries
    root "entries#index"
  end
  namespace :guestbook_with_ai_full do
    resources :entries
    root "entries#index"
  end
  resources :seed, only: :index
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  if Rails.env.test?
    # a test only route used by spec/features/it_works_spec.rb
    get "test_root", to: "rails/welcome#index", as: "test_root_rails"
  end

  # Defines the root path route ("/")
  root "home#index"
end
