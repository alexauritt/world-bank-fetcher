require 'helper'

module WorldBankFetcher
  describe CountryParser do
    let(:france) { mock_country('France', "Paris", "Europe") }
    let(:canada) { mock_country('Canada', "Ottawa", "North America") }
    
    it "should parse a country object" do
      expected = [{:name => "France", :capital => "Paris", :region => "Europe"}]
      CountryParser.parse([france]).should eq(expected)
    end
    
    it "should parse multiple country objects" do
      expected = [{:name => "France", :capital => "Paris", :region => "Europe"},
        {:name => "Canada", :capital => "Ottawa", :region => "North America"} ]
      CountryParser.parse([france, canada]).should eq(expected)
    end
    
    private
    def mock_country(name, capital, region_name)
      region_hash = Object.new
      raw_object = Object.new
      raw_object.stub(:value).and_return(region_name)
      region_hash.stub(:raw).and_return(raw_object)
      country = double('country')
      country.stub(:name).and_return(name)
      country.stub(:capital).and_return(capital)
      country.stub(:region).and_return(region_hash)
      country      
    end
    
  end  
end
