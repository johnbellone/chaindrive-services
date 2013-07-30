$:.unshift('lib').uniq!

require 'chaindrive'

use Rack::Session::Cookie
run Rack::Cascade.new [Chaindrive::API, Chaindrive::Web]
