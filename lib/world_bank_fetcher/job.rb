require 'world_bank'

module WorldBankFetcher
  class Job
    attr_reader :indicator_string, :results, :checksum
    
    def initialize(options)
      @indicator_string = indicator_string
      @results = nil
      @checksum = nil
      
      @query = build_query options
    end
    
    def fetch
      fetch_all_data query
    end

    private
    
    def build_query(options)
      options[:indicator] ? indicator_query(options[:indicator]) : countries_query
    end
    
    def indicator_query(indicator_code)
      WorldBank::Data.country('all').indicator(indicator_code)
    end
    
    def countries_query
      WorldBank::Country.all
    end
    
    def query
      @query
    end
    
    def fetch_all_data(query)
      scheduler = WorldBankFetcher::QueryScheduler.new query
      query.per_page(WorldBankFetcher::MAXIMUM_BUFFER_SIZE)
      data = scheduler.execute!
      if data.nil?
        nil
      else
        @results = WorldBankFetcher::DataParser.parse data
        @checksum = Digest::MD5.hexdigest Marshal.dump(@results)
        {:results => @results, :checksum => @checksum}
      end
    end
  end
end