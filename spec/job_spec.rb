require 'helper'

module WorldBankFetcher
  describe Job do
    let(:indicator_string) { 'SP.POP.TOTL' }
    before do
      DataParser.stub(:parse).and_return(:something)
    end
    context 'fetch' do
      it "should return nil if query shceduler returns nil" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(nil)
        job = Job.new indicator_string
        job.fetch.should be_nil
      end

      it "should not return nil if query shceduler returns non nil value" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)
        job = Job.new indicator_string
        job.fetch.should_not be_nil
      end
    
      it "returns a hash if there are no errors" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.should_receive(:execute!).and_return(:something)

        job = Job.new indicator_string
        job.fetch.should be_an_instance_of(Hash)
      end
    
      it "should receive same checksum if scheduler returns identical results" do
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.stub(:execute!).and_return(:something)

        job = Job.new indicator_string
        first = job.fetch[:checksum]
        second = job.fetch[:checksum]
        first.should eq(second)
      end
    
      it "should return unique checksums given unique results" do

        DataParser.should_receive(:parse).twice.and_return(:something, :something_else)
        WorldBank::DataQuery.any_instance.stub(:total).and_return(39)
        QueryScheduler.any_instance.stub(:execute!).and_return(:some_stuff)

        job = Job.new indicator_string
        second_job = Job.new 'different string'
        first = job.fetch[:checksum]
        second = second_job.fetch[:checksum]
        first.should_not eq(second)      
      end
    end
  end
end