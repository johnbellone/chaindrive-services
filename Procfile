web: bin/puma -t 0:4 -p $PORT -e ${RACK_ENV:-development} 
worker: bin/sidekiq -e ${RACK_ENV:-development} -r ./config/environment.rb
