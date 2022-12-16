# frozen_string_literal: true

Rails.application.routes.draw do
  resources :events, only: %i[create index destroy]

  mount Raddocs::App => '/docs'

  # "несуществующие маршруты"
  match '*unmatched', to: 'application#not_found', via: :all
end
