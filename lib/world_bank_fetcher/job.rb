require 'world_bank'

module WorldBankFetcher
  class Job
    attr_reader :results, :checksum
    
    def initialize(options)
      @results = nil
      @checksum = nil
      @job_type = options[:indicator] ? :indicator : :country
      @query = build_query options
    end
    
    def fetch
      data = fetch_all_data query
      if data        
        @checksum = checksum data
        {:results => @results, :checksum => @checksum}
      else
        nil
      end
    end

    private
    
    def checksum(data)
      Digest::MD5.hexdigest Marshal.dump(data)
    end
    
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
      scheduler = QueryScheduler.new query
      query.per_page(MAXIMUM_BUFFER_SIZE)
      scheduler.execute!
    end
  end
end