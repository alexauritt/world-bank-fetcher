require 'helper'

module WorldBankFetcher
  describe Job do
    before do
      CountryParser.stub!(:filter) do |arg|
        arg
      end
    end
    
    let(:indicator_string) { 'SP.POP.TOTL' }
        
    context 'initialize' do
      it "should accept hash w/ indicator to specify job type in intializer" do
        WorldBank::Data.should_receive(:country).with('all').and_return(stubbed_query)
        Job.new(:indicator => indicator_string)
      end
      
      it "should accept countries to indicate all countries in initializer hash" do
        WorldBank::Country.should_receive(:all).and_return(stubbed_query)
        Job.new(:countries => true)
      end
    end

    context 'fetch' do
      
      it "should not use CountryParser to filter for indicator jobs" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)

        CountryParser.should_not_receive(:filter)
        Job.new(:indicator => indicator_string).fetch        
      end
      
      it "should use CountryParser to filter for country jobs" do
        CountryParser.should_receive(:filter)
        Job.new(:countries => true).fetch
      end
      
      it "should return nil if query shceduler returns nil" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(nil)
        job = Job.new(:indicator => indicator_string)
        job.fetch.should be_nil
      end

      it "should not return nil if query shceduler returns non nil value" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)
        job = Job.new(:indicator => indicator_string)
        job.fetch.should_not be_nil
      end
    
      it "returns a hash if there are no errors" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)

        job = Job.new(:indicator => indicator_string)
        job.fetch.should be_an_instance_of(Hash)
      end
  
      context 'checksum' do
        it "should return unique checksums given unique results" do
          job = Job.new(:indicator => indicator_string)
          d1 = [:blah, :blog, :dj]
          d2 = [:bjad, :awe, :asdf]
          job.send(:checksum, d1).should_not eq(job.send(:checksum, d2))
        end
        
        it "should receive same checksum if scheduler returns identical results" do
          job = Job.new(:indicator => indicator_string)
          d1 = [:blah, :blog, :dj]
          job.send(:checksum, d1).should eq(job.send(:checksum, d1))          
        end
        
      end
    end    
    
    private
    def stubbed_query
      dummy_query = double("query")
      dummy_query.stub(:indicator)
      dummy_query
    end
  end
end