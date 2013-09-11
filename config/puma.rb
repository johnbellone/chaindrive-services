# coding: utf-8

# Store the pid of the server in the file at “path”.
pidfile 'tmp/pids/puma.pid'

# Use “path” as the file to store the server info state. This is
# used by “pumactl” to query and control the server.
state_path 'tmp/pids/puma.state'

# Configure “min” to be the minimum number of threads to use to answer
# requests and “max” the maximum.
threads 0, 4

# How many worker processes to run.
# workers 2

# Code to run when a worker boots to setup the process before booting
# the app.
#
# This can be called multiple times to add hooks.
#
# on_worker_boot do
#   puts 'On worker boot...'
# end

# Bind the server to “url”. “tcp://”, “unix://” and “ssl://” are the only
# accepted protocols.
bind "tcp://0.0.0.0:#{ENV['PORT']}"
bind 'unix://tmp/run/puma.sock'

# Instead of “bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'” you
# can also use the “ssl_bind” option.
# ssl_bind '127.0.0.1', '9292', { key: path_to_key, cert: path_to_cert }


