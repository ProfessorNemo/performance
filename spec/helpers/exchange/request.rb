# frozen_string_literal: true

module Exchange
  module Request
    include Exchange::Connection

    # с пом-ю м-да "connection" создаем новое подключение,
    # передаем клиента, отправляем get-запрос и post-запрос
    # на указанный путь и с указанными параметрами
    def get(path, client, params = {})
      # path --> events
      respond_with(
        connection(client).get(path, params)
      )
    end

    def post(path, client, params = {})
      # params = { title: 'Бесы', start_date: '01-06-2023', end_date: '01-07-2023' }
      # path --> events

      respond_with(
        connection(client).post(path, params)
      )
    end

    private

    # м-д, который декодирует полученный ответ и превращает в хэш
    def respond_with(response)
      JSON.parse response.body
    end
  end
end
