# frozen_string_literal: true

module Box
  module ApiJson
    class << self
      def call(path)
        response ||= Faraday.get(path, options).body

        JSON.parse(response, symbolize_names: true)
      end

      def options
        {
          token: ENV.fetch('TOKEN')
        }
      end
    end
  end
end
