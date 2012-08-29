require 'helper'

module WorldBankFetcher
  describe CountryParser do
    let(:france) { WorldBank::Country.new('name' => 'France', 'iso2Code' => 'FR')}
    let(:canada) { WorldBank::Country.new('name' => 'Canada', 'iso2Code' => 'CA')}
    let(:arab_world) { WorldBank::Country.new('name' => 'Arab World', 'iso2Code' => '1A')}
    let(:euro_area) {WorldBank::Country.new('name' => "Euro area", 'iso2Code' => "XC")}
     
    it "should filter expected countries" do
      CountryParser.filter([france, arab_world, canada]).should eq([france, canada])
      CountryParser.filter([canada, euro_area, france, arab_world]).should eq([canada, france])
    end    
  end  
end
