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
  

end
