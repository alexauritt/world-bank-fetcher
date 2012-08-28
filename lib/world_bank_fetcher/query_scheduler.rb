module WorldBankFetcher
  class QueryScheduler
    attr_reader :query
  
    def initialize(query)
      @query = query
      @results = []
    end
    
    def execute!
      query.per_page(MAXIMUM_BUFFER_SIZE)
      begin
        if query.is_a? WorldBank::ParamQuery
          fetch_param_query!
        elsif query.is_a? WorldBank::DataQuery
          fetch_data_query!
        else
          raise
        end
      rescue
        nil
      end
    end
  
    private
    
    def fetch_param_query!
      results = query.fetch
      rails if results.size === MAXIMUM_BUFFER_SIZE
      results 
    end
    
    def fetch_data_query!
      results = []
      total_queries.times do |i|
        res = query.page(i+1).fetch
        return nil if res.nil?
        results.concat res
      end
      results      
    end
    
    def total_queries
      query.per_page(1).fetch unless query.total
      (query.total / WorldBankFetcher::MAXIMUM_BUFFER_SIZE.to_f).ceil
    end

    def results=(results)
      @results = results
    end
  
    def results
      @results
    end
  end  
end
