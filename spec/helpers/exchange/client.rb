# frozen_string_literal: true

module Exchange
  class Client
    include Exchange::Rest

    attr_reader :token

    def initialize(token = [])
      @token = token
      @token.empty? ? @token = ENV.fetch('TOKEN') : @token
    end
  end
end
