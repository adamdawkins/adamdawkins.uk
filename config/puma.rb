require 'barnes'

before_fork do
  # worker specific setup

  Barnes.start
end

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

port        ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }



plugin :tmp_restart
