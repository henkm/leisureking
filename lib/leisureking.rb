module LeisureKing
end

require "leisureking/version"
require "leisureking/config"
require "leisureking/engine" if defined?(Rails) && Rails::VERSION::MAJOR.to_i >= 3
require "leisureking/authentication"
require "leisureking/api"


module LeisureKing
  class Error < StandardError; end


  # For testing purpose only: set the username and password
  # in environment variables to make the tests pass with your test
  # credentials.
  def self.set_credentials_from_environment
    Config.api_key 		= ENV["LEISURE_KING_API_KEY"]
    Config.api_secret = ENV["LEISURE_KING_API_SECRET"]
  end

end
