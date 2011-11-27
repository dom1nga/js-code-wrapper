# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'rake'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "js-code-wrapper"
  gem.homepage = "http://github.com/dom1nga/js-code-wrapper"
  gem.license = "MIT"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "beloved.dom1nga@gmail.com"
  gem.authors = ["dom1nga"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
RSpec::Core::RakeTask.new('spec')

task :default => :spec
