# coding: utf-8
require File.join(File.dirname(__FILE__), 'config/environment')
require File.join(File.dirname(__FILE__), 'config/database')

require 'chaindrive'
require 'sinatra/asset_pipeline/task'
Sinatra::AssetPipeline::Task.define! Chaindrive::Web

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs.push ['spec', 'spec/support']
end

Dir['lib/tasks/**/*.rake'].each { |t| load t }

task :spec => :test
task :default => :spec
