require 'chaindrive/api'
require 'chaindrive/web'

use Rack::Session::Cookie
run Rack::Cascade.new [Chaindrive::API, Chaindrive::Web]
