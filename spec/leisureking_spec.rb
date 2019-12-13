RSpec.describe LeisureKing do
  require 'yaml'
  it "has a version number" do
    expect(LeisureKing::VERSION).not_to be nil
  end

  context "API calls" do

    before(:all) do
      LeisureKing.set_credentials_from_environment
    end

    describe 'assortiment' do
      it "returns assortiment" do
        result = LeisureKing::API.send_request("assortiment/get")
        # puts result["data"].to_yaml
        expect(result["status"]).to eq "OK"
        expect(result["data"]).to be_kind_of Array
      end

      it "returns assortiment details" do
        result = LeisureKing::API.send_request("assortiment/getassortimentdatabyassortimentid", {id_assortiment: 5625})
        expect(result["status"]).to eq "OK"
        expect(result["data"]).to be_kind_of Hash
        expect(result["data"]["FKid_prijstype"]).to eq "1"
      end

      xit "returns a list of pictures" do
        result = LeisureKing::API.send_request("assortiment/getpictures", {id_assortiment: 5625, aslink: true})
        puts result
      end
      
      
    end
    
  end
end
