# frozen_string_literal: true

# для отправки запросов

module Exchange
  module Rest
    include Exchange::Request

    def performances(params = {})
      get 'events', self, params
    end

    # Создать новый спектакль с заданными параметрами
    def create_performance(params)
      post 'events', self, params
    end
  end
end

# self будет указывать на Client, потому что в Client "include Helpers::Exchange::Rest".
# Берём self, передаём его в get. Затем в get (см. module Request) передаем "client",
# который в себе содержит токен и затем в подключении (см. module Connection) мы этого
# "client" принимаем и вытаскиваем его токен ('Api-Token' => client.token), таким образом
# пристыковывая его к заголовкам.
