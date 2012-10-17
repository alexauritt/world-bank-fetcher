require 'world_bank'

module WorldBankFetcher
  class CountryParser

    def self.filter(data_collection)
      if (data_collection.first.is_a? WorldBank::Country)
        filter_countries data_collection
      else
        filter_data_from_non_countries data_collection
      end        
    end
    
    def self.data_from_official_country?(datum)
      !non_country_codes.include? datum.raw.country.id
    end
    
    private
    def self.filter_countries(data_collection)
      data_collection.reject {|country| non_country_codes.include? country.iso2_code }
    end
    
    def self.filter_data_from_non_countries(data_collection)
      data_collection.reject { |datum| data_from_official_country? datum }
    end
    
    def self.non_country_codes
      NON_COUNTRIES.map {|country_info| country_info[:iso2_code] }
    end
    
    NON_COUNTRIES = [
      {:name => "Arab World", :iso2_code => "1A"}, 
      {:name => "Caribbean small states", :iso2_code => "S3"}, 
      {:name => "East Asia & Pacific (developing only)", :iso2_code => "4E"}, 
      {:name => "East Asia & Pacific (all income levels)", :iso2_code => "Z4"}, 
      {:name => "Europe & Central Asia (developing only)", :iso2_code => "7E"}, 
      {:name => "Europe & Central Asia (all income levels)", :iso2_code => "Z7"}, 
      {:name => "Euro area", :iso2_code => "XC"}, 
      {:name => "European Union", :iso2_code => "EU"}, 
      {:name => "High income", :iso2_code => "XD"}, 
      {:name => "Heavily indebted poor countries (HIPC)", :iso2_code => "XE"}, 
      {:name => "Not classified", :iso2_code => "XY"}, 
      {:name => "Latin America & Caribbean (developing only)", :iso2_code => "XJ"}, 
      {:name => "Latin America & Caribbean (all income levels)", :iso2_code => "ZJ"}, 
      {:name => "Least developed countries: UN classification", :iso2_code => "XL"}, 
      {:name => "Low income", :iso2_code => "XM"}, 
      {:name => "Lower middle income", :iso2_code => "XN"}, 
      {:name => "Low & middle income", :iso2_code => "XO"}, 
      {:name => "Middle East & North Africa (all income levels)", :iso2_code => "ZQ"}, 
      {:name => "Middle income", :iso2_code => "XP"}, 
      {:name => "Middle East & North Africa (developing only)", :iso2_code => "XQ"}, 
      {:name => "North America", :iso2_code => "XU"}, 
      {:name => "High income: nonOECD", :iso2_code => "XR"}, 
      {:name => "High income: OECD", :iso2_code => "XS"}, 
      {:name => "OECD members", :iso2_code => "OE"}, 
      {:name => "Other small states", :iso2_code => "S4"}, 
      {:name => "Pacific island small states", :iso2_code => "S2"}, 
      {:name => "South Asia", :iso2_code => "8S"}, 
      {:name => "Sub-Saharan Africa (developing only)", :iso2_code => "ZF"}, 
      {:name => "Sub-Saharan Africa (all income levels)", :iso2_code => "ZG"}, 
      {:name => "Small states", :iso2_code => "S1"}, 
      {:name => "Upper middle income", :iso2_code => "XT"}, 
      {:name => "World", :iso2_code => "1W"}
    ]
  end
end


  
  
  
  
  
