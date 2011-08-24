set :user, "staging"
set :runner, "staging"
set :use_sudo, false
set :rails_env, "staging"

set :deploy_to, "/home/staging/www/hp99"
set :branch, "staging"

role :web, "staging.idhd.fr"
role :app, "staging.idhd.fr"
role :db,  "staging.idhd.fr", :primary => true

set :default_environment, {'PATH' => '$PATH:$HOME/.rbenv/bin'}
set :bundle_cmd, '/home/staging/.rbenv/shims/bundle'

set :unicorn_binary, "#{bundle_cmd} exec unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn_staging.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

# before "deploy", "rbenv:init"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end