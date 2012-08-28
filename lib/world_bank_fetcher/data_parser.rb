require 'world_bank'

module WorldBankFetcher
  class DataParser
    def self.parse(data_collection)
      indicator_id = data_collection.first.id
      results = {:id => indicator_id }
      data_collection.each do |datum|
        return nil unless datum.id === indicator_id
        results[datum.others['country']['value']] ||= []
        results[datum.others['country']['value']] << { :year => datum.date, :value => datum.value }
      end
      results
    end
  end
end