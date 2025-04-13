# == Route Map
#
#                            Prefix Verb   URI Pattern                            Controller#Action
#                                          /assets                                Propshaft::Server
#                          messages GET    /messages(.:format)                    messages#index
#                                   POST   /messages(.:format)                    messages#create
#                       new_message GET    /messages/new(.:format)                messages#new
#                      edit_message GET    /messages/:id/edit(.:format)           messages#edit
#                           message GET    /messages/:id(.:format)                messages#show
#                                   PATCH  /messages/:id(.:format)                messages#update
#                                   PUT    /messages/:id(.:format)                messages#update
#                                   DELETE /messages/:id(.:format)                messages#destroy
#                   test_root_rails GET    /test_root(.:format)                   rails/welcome#index
#                rails_health_check GET    /up(.:format)                          rails/health#show
#                              demo GET    /demo(.:format)                        demos#show
#  turbo_recede_historical_location GET    /recede_historical_location(.:format)  turbo/native/navigation#recede
#  turbo_resume_historical_location GET    /resume_historical_location(.:format)  turbo/native/navigation#resume
# turbo_refresh_historical_location GET    /refresh_historical_location(.:format) turbo/native/navigation#refresh

Rails.application.routes.draw do
  resources :messages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  if Rails.env.local?
    # a test only route used by spec/features/it_works_spec.rb
    get "test_root", to: "rails/welcome#index", as: "test_root_rails"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resource :demo, only: [:show]

  # Defines the root path route ("/")
  # root "posts#index"
end
