$:.unshift('lib').uniq!

require 'chaindrive'

use Rack::Session::Cookie, {
  domain: 'api.chaindrive.io',
  path: '/',
  expire_after: 28800,
  secret: ENV['RACK_SESSION_COOKIE_SECRET']
}
run Rack::Cascade.new [Chaindrive::API, Chaindrive::Web]
