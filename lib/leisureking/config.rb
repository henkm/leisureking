#
# Configuration object for storing some parameters required for making transactions
#

module ::LeisureKing::Config
  class << self
    attr_accessor :api_key
    attr_accessor :api_secret
    attr_accessor :verbose
    attr_accessor :api_version
    attr_accessor :api_base_url
    attr_accessor :environment
    attr_accessor :client_email  # Who is making the request? For optional HTTP Header
    


    # Set's the default value's to nil and false
    # @return [Hash] configuration options
    def init!
      @defaults = {
        :@api_key       => nil,
        :@api_secret    => nil,
        :@verbose       => false,
        :@environment   => :test,
        :@api_base_url  => 'https://api.leisureking.eu',
        :@client_email  => '',
        :@api_version   => '1l'
      }
    end

    # Resets the value's to there previous value (instance_variable)
    # @return [Hash] configuration options
    def reset!
      @defaults.each { |key, value| instance_variable_set(key, value) }
    end

    # Set's the new value's as instance variables
    # @return [Hash] configuration options
    def update!
      @defaults.each do |key, value|
        instance_variable_set(key, value) unless instance_variable_defined?(key)
      end
    end
  end
  init!
  reset!

end
