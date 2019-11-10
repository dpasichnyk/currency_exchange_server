Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :rates_histories
  end
end
