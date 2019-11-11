Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :rates_histories, only: :index

    get 'currencies/all'
    get 'currencies/convert'
  end
end
