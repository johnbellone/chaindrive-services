# coding: utf-8
require File.expand_path('../config/boot', __FILE__)

if Chaindrive.development?
  $logger.info 'Loading NewRelic in developer mode...'
  require 'new_relic/rack/developer_mode'
  use NewRelic::Rack::DeveloperMode
  use OmniAuth::Strategies::Developer
end

NewRelic::Agent.manual_start

use Rack::CommonLogger, $logger
use Rack::Cache do
  set :verbose, true
  set :metastore, Chaindrive.cache_metastore
  set :entitystore, Chaindrive.cache_entitystore
  set :allow_reload, true if Chaindrive.development?
end
use Rack::Session::Cookie, {
  domain: 'chaindrive.io',
  path: '/',
  expire_after: 28800,
  secret: Chaindrive.session_cookie
}
run Rack::Cascade.new [Chaindrive::Server, Chaindrive::Web]
