$:.unshift('lib').uniq!

# Default some values that we would normally expect at runtime.
ENV['RACK_ENV'] ||= 'test'
ENV['RACK_SESSION_COOKIE_SECRET'] ||= 'test'
ENV['DATABASE_URL'] ||= "sqlite://tmp/#{ENV['RACK_ENV']}.db"

require 'rubygems'
require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

require 'chaindrive'

# Set a default logger that for production environments will write to the
# system log. From there we can pipe that to logstash.
if Chaindrive.development?
  require 'logger'
  $logger = Logger.new($stdout)
  $logger.level = Logger::DEBUG
else
  require 'syslogger'
  $logger = Syslogger.new('chaindrive', Syslog::LOG_PID, Syslog::LOG_LOCAL0)
  $logger.level = Logger::INFO
end








