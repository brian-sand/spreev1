# config valid only for current version of Capistrano
lock ">=3.8.1"

set :application, "spreev1"
set :repo_url, "git@github.com:brian-sand/spreev1.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, "/home/spree1user/www/spreev1"
set :deploy_to, "/home/spree1user/spreev1"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/spree"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {"RAILS_ENV": 'production'}

# Default value for keep_releases is 5
# set :keep_releases, 5
