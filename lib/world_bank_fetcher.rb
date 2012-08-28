require "world_bank_fetcher/version"
require 'world_bank'
require 'world_bank_fetcher/job'
require 'world_bank_fetcher/query_scheduler'
require 'world_bank_fetcher/data_parser'
require 'world_bank_fetcher/country_parser'

module WorldBankFetcher
  MAXIMUM_BUFFER_SIZE = 500
  DEFAULT_INITIAL_BUFFER_SIZE = 50
end