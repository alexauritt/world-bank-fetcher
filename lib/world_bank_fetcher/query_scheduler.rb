module WorldBankFetcher
  class QueryScheduler
    attr_reader :query
  
    def initialize(query)
      @query = query
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
      results = query.fetch
      if query.total > MAXIMUM_BUFFER_SIZE
        total_queries.times do |i|
          unless i == 0
            results.concat query.page(i+1).fetch
          end
        end
        results
      else
        results
      end
    end
    
    def total_queries
      (query.total / MAXIMUM_BUFFER_SIZE.to_f).ceil
    end
  end  
end
