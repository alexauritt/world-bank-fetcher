require 'helper'

module WorldBankFetcher
  describe IndicatorDataParser do
    let(:other_attributes) { { }}
    let(:good_data_1) { WorldBank::Data.new(attrs_with 'value' => 534) }
    let(:good_data_2) { WorldBank::Data.new(attrs_with 'value' => 32) }
    let(:bad_data_1) { WorldBank::Data.new(attrs_with 'value' => nil) }
    let(:bad_data_2) { WorldBank::Data.new(attrs_with 'value' => nil) }

    it "should filter data with nil values" do
      CountryParser.stub(:data_from_official_country?).and_return(true)
      good_data = [good_data_1, good_data_2]
      IndicatorDataParser.filter([good_data_1, bad_data_2, bad_data_1, good_data_2]).should eq(good_data)
    end
    
    it "should confirm that data is from an actual country by passing scores with values to CountryParser" do
      CountryParser.should_receive(:data_from_official_country?).exactly(2).times.and_return(true)
    
      IndicatorDataParser.filter([good_data_1, bad_data_2, bad_data_1, good_data_2])
    end
    
    it "should filter data rejected by CountryParser" do
      CountryParser.stub(:data_from_official_country?).with(good_data_1).and_return(false)
      CountryParser.stub(:data_from_official_country?).with(good_data_2).and_return(true)

      IndicatorDataParser.filter([good_data_1, good_data_2]).should eq([good_data_2])
    end
    
    private
    
    def attrs_with(attr)
      {'indicator' => {'value' => '2', 'id' => 23}, 'date' => '1999'}.merge attr
    end
    
  end
end