require 'helper'

module WorldBankFetcher
  describe DataParser do
    let(:indicator_id) { 'DJ.JIE.JIDL' }
    let(:datum1) { mock_data(:country => 'Mexico', :year => 1990, :id => indicator_id, :value => 234) }
    let(:data) { [datum1] }

    it "should parse data and return expected hash structure" do
      actual = DataParser.parse data
      actual.should eq({:id => indicator_id, 'Mexico' => [{:year => 1990, :value => 234}]})
    end
  
    it "should return nil when provided data for multiple indicators" do
      datum2 = mock_data(:country => 'Mexico', :year => 1990, :id => 'NJ.EKD.DKEL', :value => 234)
      DataParser.parse([datum1, datum2]).should be_nil
    end
  
    it "should handle more complext data" do
      d1 = mock_data(:country => 'Mexico', :year => 1990, :id => indicator_id, :value => 234)
      d2 = mock_data(:country => 'Mexico', :year => 1992, :id => indicator_id, :value => 456)
      d3 = mock_data(:country => 'France', :year => 1990, :id => indicator_id, :value => 789)
      expected = {:id => indicator_id, 'Mexico' => [{:year => 1990, :value => 234}, {:year => 1992, :value => 456}], 'France' => [{:year => 1990, :value => 789}]}

      DataParser.parse([d1,d2,d3]).should eq(expected)    
    end

    it "should mock data properly" do
      f = data.first
      f.value.should eq(234)
      f.id.should eq('DJ.JIE.JIDL')
      f.date.should eq(1990)
      f.others['country']['value'].should eq('Mexico')
    end
  
    def mock_data(attr)
      mockal = Object.new
      mockal.stub(:value).and_return(attr[:value])
      mockal.stub(:id).and_return(attr[:id])
      mockal.stub(:date).and_return(attr[:year])

      country_data = {'country' => {'value' => attr[:country]}}
      mockal.stub(:others).and_return(country_data)
      mockal
    end
  end
end
