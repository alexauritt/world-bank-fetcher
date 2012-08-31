require 'helper'

module WorldBankFetcher
  describe Job do    
    let(:indicator_string) { 'SP.POP.TOTL' }
        
    describe 'initialize' do
      it "should accept hash w/ indicator to specify job type in intializer" do
        country_parser_filters_nothing!
        WorldBank::Data.should_receive(:country).with('all').and_return(stubbed_query)
        Job.new(:indicator => indicator_string)
      end
      
      it "should accept countries to indicate all countries in initializer hash" do
        country_parser_filters_nothing!
        WorldBank::Country.should_receive(:all).and_return(stubbed_query)
        Job.new(:countries => true)
      end
    end

    describe 'fetch' do
      it "should return nil if query shceduler returns nil" do
        country_parser_filters_nothing!
        QueryScheduler.any_instance.should_receive(:execute!).and_return(nil)
        job = Job.new(:indicator => indicator_string)
        job.fetch.should be_nil
      end

      it "should not return nil if query shceduler returns non nil value" do
        country_parser_filters_nothing!
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)
        job = Job.new(:indicator => indicator_string)
        job.fetch.should_not be_nil
      end
    
      it "filters return value from Query Scheduler through CountryParser" do
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)
        CountryParser.should_receive(:filter).with(:something).and_return(:something_else)
        job = Job.new(:indicator => indicator_string)
        job.fetch.should eq(:something_else)
      end
    end
    
    private
    def stubbed_query
      dummy_query = double("query")
      dummy_query.stub(:indicator)
      dummy_query
    end
    
    def country_parser_filters_nothing!
      CountryParser.stub!(:filter) do |arg|
        arg
      end
    end
  end
end