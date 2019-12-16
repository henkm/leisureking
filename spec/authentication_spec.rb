RSpec.describe LeisureKing::Authentication do
  
	describe "configuration" do
    before(:all) do
      # set correct configuration
      LeisureKing.set_credentials_from_environment
    end

    it 'has a 40 character API key' do
    	expect(LeisureKing::Config.api_key).to be_kind_of(String)
    	expect(LeisureKing::Config.api_key.length).to eq(40)
    end

    it "is in test environment" do
      expect(LeisureKing::Config.environment).to eq :test
    end
    

    it "has no api token" do
      expect(LeisureKing::Authentication.token).to be_nil
    end
  end
  
  describe ".get_token" do
    it "retrieves a JSON response with a token attribute" do
      response = LeisureKing::Authentication.get_token
      expect(LeisureKing::Authentication.token.length).to be > 200
    end
  end

  describe ".has_valid_api_key" do
    it "has a date in the future" do
      puts Time.now
      puts LeisureKing::Authentication.api_key_valid_until
      expect(LeisureKing::Authentication.api_key_valid_until).to be > Time.now
    end
    
    it "returns a true if the API keys has a date in the future" do
      expect(LeisureKing::Authentication.has_valid_api_key).to be true
    end
  end
  

end
