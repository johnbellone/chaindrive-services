web: bin/puma -C ./config/puma.rb -e ${RACK_ENV:-development}
worker: bin/sidekiq -e ${RACK_ENV:-development} -r ./config/environment.rb
