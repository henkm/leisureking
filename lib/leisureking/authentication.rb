module LeisureKing::Authentication
  require 'digest'
  require 'jwt'
  require 'base64'
  require 'openssl'

  # The communication layer implements all the methods available in the LeisureKing API
  class << self
    attr_accessor :token

    # Set's the default value's to nil and false
    # @return [Hash] conguration options
    def init!
      @defaults = {
        :@token    => nil,
      }
    end

    def get_token
      body = {
        apikey: LeisureKing::Config.api_key,
        secret: LeisureKing::Config.api_secret
      }
      result = LeisureKing::API.send_request("authenticate", body)
      if result["status"] && result["status"] == "OK"
        self.token = result["data"]["token"]
      end
      return result
    end

  # Parses the current API key and checks if the 'exp' attribute
    # represents a date in the future.
    def has_valid_api_key
      return self.token != nil && api_key_valid_until > Time.now
    end

    def api_key_valid_until
      decoded_token = JWT.decode self.token, nil, false
      Time.at(decoded_token.first["exp"])
    end

  end
  init!
end