require 'api/database'
require 'api/chaindrive'

use Rack::Session::Cookie
run Chaindrive::API
