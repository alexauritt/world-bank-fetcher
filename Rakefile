#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require './lib/world_bank_fetcher'

RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec

task :queries do
  puts WorldBankFetcher::Job.new('SP.POP.TOTL').fetch ? "QUERY SUCCESSFUL!" : "QUERY FAILURE!!!!!!!!!!"
end
