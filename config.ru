require File.expand_path('../config/environment', __FILE__)
require File.expand_path('../config/database', __FILE__)

if Chaindrive.development?
  puts "Loading NewRelic in developer mode..."
  require 'new_relic/rack/developer_mode'
  use NewRelic::Rack::DeveloperMode
  use OmniAuth::Strategies::Developer
end

NewRelic::Agent.manual_start

use Rack::CommonLogger, $logger
use Rack::Session::Cookie, 
  domain: 'registry.chaindrive.io',
  path: '/',
  expire_after: 28800,
  secret: Chaindrive.session_cookie
run Rack::Cascade.new [Chaindrive::API, Chaindrive::Webhook]
