require 'helper'
require 'world_bank'

module WorldBankFetcher
  describe QueryScheduler do
    let(:query) { WorldBank::Data.country('all').indicator('SP.POP.TOTL') }
    let(:scheduler) { QueryScheduler.new(query) }
    let(:fake_results) { [:some, :stuff, :goes, :here] }

    before do
      query.stub(:total).and_return(23)
    end
  
    it "should trigger query fetch" do
      query.should_receive(:fetch).at_least(:once)
      scheduler.execute!
    end

    it "should return nil if query fetch returns nil" do
      query.stub(:fetch).and_return(nil)
      scheduler.execute!.should be_nil
    end
  
    it "should query once and return contents if total is not greater than max for already filled query" do 
      query.should_receive(:fetch).once.and_return(fake_results)
      query.stub(:total).and_return(MAXIMUM_BUFFER_SIZE - 1)
      fake_results = scheduler.execute!
      fake_results.should eq(fake_results)
    end
  
    it "should query twice and return contents if total is just barely greater than max for already filled query" do
      query.should_receive(:fetch).twice.and_return(fake_results)
      query.stub(:total).and_return(MAXIMUM_BUFFER_SIZE + 1)
      fake_results = scheduler.execute!
    end
  
    it "should call preliminary fetch on query if total is nil, then full data query" do
      query.should_receive(:total).and_return(nil)
      query.should_receive(:fetch).twice.and_return(fake_results)
      query.should_receive(:total).and_return(DEFAULT_INITIAL_BUFFER_SIZE - 1)
      scheduler.execute!
    end

    it "should call preliminary fetch on query if total is nil, then two full data queries given larger data set" do
      query.should_receive(:total).and_return(nil)
      query.should_receive(:fetch).exactly(3).times.and_return(fake_results)
      query.should_receive(:total).and_return(MAXIMUM_BUFFER_SIZE + 1)
      scheduler.execute!
    end
  
    it "execute should return single array of data" do
      query.should_receive(:fetch).twice.and_return(fake_results)
      query.stub(:total).and_return(MAXIMUM_BUFFER_SIZE + 1)
    
      results = scheduler.execute!
      results.should eq([:some, :stuff, :goes, :here, :some, :stuff, :goes, :here])
    end  
  end
end
