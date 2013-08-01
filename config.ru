require File.expand_path('../config/environment', __FILE__)

if ENV['RACK_ENV'] == 'development'
  puts "Loading NewRelic in developer mode..."
  require 'new_relic/rack/developer_mode'
  use NewRelic::Rack::DeveloperMode
end

NewRelic::Agent.manual_start

use Rack::Session::Cookie, 
  domain: 'registry.chaindrive.io',
  path: '/',
  expire_after: 28800,
  secret: ENV['RACK_SESSION_COOKIE_SECRET']
run Rack::Cascade.new [Chaindrive::API, Chaindrive::Webhook]
