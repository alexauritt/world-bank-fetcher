module WorldBankFetcher
  class QueryScheduler
    attr_reader :query
  
    def initialize(query)
      @query = query
      @results = []
    end
    
    def execute!
      begin
        query.per_page(WorldBankFetcher::MAXIMUM_BUFFER_SIZE)
        total_queries.times do |i|
          res = query.page(i+1).fetch
          return nil if res.nil?
          results.concat res
        end
        results
      rescue
        nil
      end
    end
  
    private
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
