set :application, "hp99"
set :repository,  "git@github.com:barodeur/hp99"

set :scm, :git

set :normalize_asset_timestamps, false

ssh_options[:forward_agent] = true

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

after "deploy:setup", "symlinks:mkdir"
# before "deploy", "rbenv:init"
after "deploy:update_code", "symlinks:db", "symlinks:mailers", "symlinks:airbrake", "assets:precompile"
after "deploy", "deploy:cleanup"

namespace :rbenv do
  task :version do
    run 'rbenv version'
  end

  task :init do
    run 'source $HOME/.bashrc'
  end
end

namespace :symlinks do
  desc "Symlink database config file"
  task :db do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{current_release}/config/mongoid.yml"
  end

  desc "Symlink mailers config file"
  task :mailers do
    run "ln -nfs #{shared_path}/config/mailers.yml #{current_release}/config/mailers.yml"
  end

  desc "Symlink airbrake config file"
  task :airbrake do
    run "ln -nfs #{shared_path}/config/airbrake.yml #{current_release}/config/airbrake.yml"
  end

  desc "Create dirs"
  task :mkdir do
    run "mkdir -p #{shared_path}/config"
  end
end

namespace :assets do
  desc "Precompile assets"
  task :precompile do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} #{bundle_cmd} exec rake assets:precompile"
  end
end
        require './config/boot'
        require 'airbrake/capistrano'
