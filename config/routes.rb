Rails.application.routes.draw do
  resources :events, only: %i[create index destroy]
end
