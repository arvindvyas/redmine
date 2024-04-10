# frozen_string_literal: true

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup  DefaultRackup if defined?(DefaultRackup)
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

bind "unix:///home/ubuntu/apps/redmine/shared/sockets/puma.sock"



stdout_redirect "/home/ubuntu/apps/redmine/shared/log/puma.stdout.log", "/home/ubuntu/apps/redmine/shared/log/puma.stderr.log", true

pidfile "/home/ubuntu/apps/redmine/shared/pids/puma.pid"
state_path "/home/ubuntu/apps/redmine/shared/pids/puma.state"

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end


