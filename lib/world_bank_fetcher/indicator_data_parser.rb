require 'world_bank'

module WorldBankFetcher
  class IndicatorDataParser

    def self.filter(data_collection)
      # if (data_collection.first.is_a? WorldBank::Country)
      #   filter_countries data_collection
      # else
      #   filter_data_from_non_countries data_collection
      # end        
      data_collection
    end
  end
end