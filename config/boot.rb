# coding: utf-8
require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'database')

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

Grape::API.logger = $logger if defined?(Sidekiq)
Sidekiq.logger = $logger if defined?(Sidekiq)
