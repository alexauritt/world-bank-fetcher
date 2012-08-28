require 'world_bank'

module WorldBankFetcher
  class CountryParser
    def self.parse(data_collection)
      results = []
      data_collection.each do |datum|
        current_country = {}
        current_country[:name] = datum.name
        current_country[:capital] = datum.capital
        current_country[:region] = datum.region.raw.value
        results << current_country
      end
      results
    end
  end
end
