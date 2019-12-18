module LeisureKing::API

  # The communication layer implements all the methods available in the LeisureKing API
  class << self

    require 'rest-client'  	
    require 'json'

    # Sends a request to the LeisureKing API and returns the parsed results
    
    def base_uri
      "https://api.leisureking.eu/v#{LeisureKing::Config.api_version}"
    end

    def send_request(endpoint, body = {})
      url = "#{base_uri}/#{endpoint}"
      body[:environment] = LeisureKing::Config.environment
      begin

        unless LeisureKing::Authentication.has_valid_api_key
          unless endpoint == "authenticate"
            puts "Requesting new API Token" if LeisureKing::Config.verbose
            LeisureKing::Authentication.get_token
          end
        end

        if LeisureKing::Config.verbose
          puts "Sending request to #{url}"
          puts "Body:\n#{body.to_json}" if body
        end

        begin
          result = RestClient.post(url, body.to_json, headers) do |response, request, res, &block|
            if [301, 302, 307].include? response.code
              redirected_url = response.headers[:location]
              if LeisureKing::Config.verbose
                puts "Redirecting request to #{redirected_url}"
                puts "Headers:\n#{headers.to_json}" if headers
                puts "Body:\n#{body.to_json}" if body
              end
              RestClient.post(redirected_url, body.to_json, headers)
            else
              # puts "Response: #{response}"
              # response.return!(request, res, &block)
              response.return!
            end
          end
        rescue RestClient::Unauthorized, RestClient::Forbidden => err
          if LeisureKing::Config.verbose
            puts "Backtrace:" 
            puts err.backtrace
          end
          raise "Access denied. API Response:\n#{err}."
        end

        puts "Result:\n#{result}" if LeisureKing::Config.verbose
        return JSON.parse(result)

      rescue RestClient::BadRequest => err
        raise "Bad Request. API Response:\n#{err.response}"
      end
    end

    # HTTP headers to send in each request

    def headers
     h = {
        content_type: :json, 
        accept: :json, 
        cache_control: 'no-cache'
      }
      # add requesters email address for human communication
      if LeisureKing::Config.client_email && LeisureKing::Config.client_email != ''
        h[:from] = LeisureKing::Config.client_email   # email address for human communication
      end
      if LeisureKing::Authentication.has_valid_api_key
        h["Authorization"] = "Token #{LeisureKing::Authentication.token}"
      end
      return h
    end

  end
end