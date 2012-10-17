require 'helper'

module WorldBankFetcher
  describe IndicatorDataParser do
    let(:other_attributes) { { }}
    let(:good_data_1) { WorldBank::Data.new(attrs_with 'value' => 534) }
    let(:good_data_2) { WorldBank::Data.new(attrs_with 'value' => 32) }
    let(:bad_data_1) { WorldBank::Data.new(attrs_with 'value' => nil) }
    let(:bad_data_2) { WorldBank::Data.new(attrs_with 'value' => nil) }

    
    it "should filter data with nil values" do
      # CountryParser.filter([france, arab_world, canada]).should eq([france, canada])
      good_data = [good_data_1, good_data_2]
      IndicatorDataParser.filter([good_data_1, bad_data_2, bad_data_1, good_data_2]).should eq(good_data)
    end
    
    private
    
    def attrs_with(attr)
      {'indicator' => {'value' => '2', 'id' => 23}, 'date' => '1999'}.merge attr
    end
    
  end
end