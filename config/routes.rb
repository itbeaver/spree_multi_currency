Spree::Core::Engine.add_routes do
  post '/currency/set', to: 'currency#set', defaults: { format: :json }, as: :set_currency
  post '/region/set', to: 'region#set', defaults: { format: :json }, as: :set_region

  namespace :admin do
    resources :products do
      resources :prices, only: [:index, :create]
    end
  end
end
