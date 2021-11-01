require 'mina/rails'
require 'mina/git'
require 'mina/rvm'    # for rvm support. (https://rvm.io)
require 'mina/multistage'
require 'mina/bundler'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :ssh_options, '-A'
set :forward_agent, true
set :application_name, 'diamon_jwellery_inventory'
set :deploy_to, '/home/deployer/apps/diamon_jwellery_inventory'
set :repository, 'https://github.com/codertcet111/diamon_jwellery_inventory.git'
set :user, "deployer"
set :keep_releases, 5
set :execution_mode, :system

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/unicorn.rb')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
invoke :'rvm:use', 'ruby-2.7.0@default'

task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use', 'ruby-2.7.0@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %[mkdir -p "#{fetch(:shared_path)}/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/log"]

  command %[mkdir -p "#{fetch(:shared_path)}/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/config"]

  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  comment  %{"Be sure to edit #{fetch(:shared_path)}/config/database.yml"}

  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  comment %{"Be sure to edit #{fetch(:shared_path)}/config/secrets.yml"}

  command %[touch "#{fetch(:shared_path)}/config/unicorn.rb"]
  comment %{"Be sure to edit #{fetch(:shared_path)}/config/unicorn.rb"}

  # command %[touch "#{fetch(:shared_path)}/config/master.key"]
  # comment %{"Be sure to edit #{fetch(:shared_path)}/config/master.key"}

  # command %[touch "#{fetch(:shared_path)}/config/sidekiq.yml"]
  # comment %{"Be sure to edit #{fetch(:shared_path)}/config/sidekiq.yml"}

  command %[mkdir -p "#{fetch(:shared_path)}/tmp/pids/"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/pids"]
  command %[sudo ln -nfs #{fetch(:current_path)}/config/unicorn_init.sh /etc/init.d/unicorn_diamon_jwellery_inventory]
  command %[sudo ln -nfs #{fetch(:current_path)}/config/nginx.conf /opt/nginx/conf/nginx.conf]
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
        command %[chmod +x #{fetch(:current_path)}/config/unicorn_init.sh]
        invoke :'whenever:clear'
        invoke :'whenever:write'
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

namespace :whenever do
  desc "Clear crontab"
  task :clear do
    command %{
      echo "-----> Clear crontab for #{fetch(:domain)}"
      #{echo_cmd %[cd #{fetch(:current_path)} ; bundle exec whenever --clear-crontab --set environment=production]}
    }
  end
  desc "Write crontab"
  task :write do
    command %{
      echo "-----> Update crontab for #{fetch(:domain)}"
      #{echo_cmd %[cd #{fetch(:current_path)} ;bundle exec whenever --write-crontab --set environment=production]}
    }
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
