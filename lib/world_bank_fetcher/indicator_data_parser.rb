require 'world_bank'

module WorldBankFetcher
  class IndicatorDataParser

    def self.filter(data_collection)
      data = data_collection.keep_if {|datum| datum.value != nil }
    end
  end
end