require 'world_bank'

module WorldBankFetcher
  class IndicatorDataParser

    def self.filter(data_collection)
      data = data_collection.keep_if {|datum| (datum.value != nil) and CountryParser.data_from_official_country?(datum) }
    end
  end
end