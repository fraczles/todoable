require 'HTTParty'
require 'todoable/routes'
require 'todoable/version'

# TODOable namespace
module Todoable
  # Client wrap API endpoints
  class Client
    include HTTParty
    include Routes

    base_uri 'http://todoable.teachable.tech/api'

    def default_username
      ENV['TODOABLE_USERNAME']
    end

    def default_password
      ENV['TODOABLE_PASSWORD']
    end

    def initialize(username: default_username, password: default_password)
      if username.nil? || password.nil?
        raise ArgumentError, 'Must enter valid username and password'
      end

      @auth = {
        username: username,
        password: password
      }
    end

    private

    def protected_headers
      refresh_token!
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Token token=#{@token['token']}"
      }
    end

    def refresh_token!
      return unless token_invalid?
      @token = fetch_token
    end

    def token_invalid?
      return true if @token.nil?
      Time.now.utc > Time.parse(@token['expires_at'])
    end

    def fetch_token
      self.class.post(
        '/authenticate',
        basic_auth: @auth,
        headers: {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      )
    end
  end
end
