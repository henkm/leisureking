module LeisureKing
  #
  # Simpel extend on the +Rails::Engine+ to add support for a new 
  # config section within the environment configs
  #
  # @example default
  #   # /config/environments/development.rb
  #   config.leisure_king.api_key  = "12343465sdfgsadr324"
  #
  
  class Engine < ::Rails::Engine
    isolate_namespace LeisureKing
    config.leisure_king = LeisureKing::Config
  end
end
