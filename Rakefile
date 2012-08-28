#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'world_bank_fetcher'

RSpec::Core::RakeTask.new(:spec)
# 'SP.POP.TOTL'
task :test => :spec
task :default => :spec

task :indicator, :indicator_code do |t, args|
  puts WorldBankFetcher::Job.new(:indicator => args[:indicator_code]).fetch ? "QUERY SUCCESSFUL!" : "QUERY FAILURE!!!!!!!!!!"
end

task :countries do
  results = WorldBankFetcher::Job.new(:countries => true).fetch
  puts results ? "QUERY SUCCESSFUL!" : "QUERY FAILURE!!!!!!!!!!"
  puts "#{results}"
end