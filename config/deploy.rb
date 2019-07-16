# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "my_app_name"
set :repo_url, "git@example.com:me/my_repo.git"

set :assets_roles, [:app]
set :deploy_ref, ENV["DEPLOY_REF"]
set :deploy_ref_type, ENV["DEPLOY_REF_TYPE"]
set :bundle_binstubs, nil

if fetch(:deploy_ref)
  set :branch, fetch(:deploy_ref)
else
  raise "Please set $DEPLOY_REF"
end

set :rvm_ruby_version, "#{ENV['RB_VERSION']}"
set :deploy_to, "/usr/local/rails_apps/#{fetch :application}"
set :settings, YAML.load_file(ENV["SETTING_FILE"] ||"config/deploy/settings.yml")
set :instances, get_intances_targets unless ENV["LOCAL_DEPLOY"]

set :deploy_via,      :remote_cache
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

default_linked_files = [
  "config/database.yml",
  "config/application.yml"
]
settings_linked_files = fetch(:settings)["linked_files"]
default_linked_files.concat(settings_linked_files) if settings_linked_files
# Default value for :linked_files is []
append :linked_files, *default_linked_files

set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)

# Default value for default_env is {}
set :default_env, File.read("/home/deploy/.env").split("\n").inject({}){|h,var|
  k_v = var.gsub("export ","").split("=")
  h.merge k_v.first.downcase => k_v.last.gsub("\"", "")
}.symbolize_keys

namespace :deploy do
  desc "create database"
  task :create_database do
    on roles(:db) do |host|
      within "#{release_path}" do
        with rails_env: ENV["RAILS_ENV"] do
          execute :rake, "db:create"
        end
      end
    end
  end
  before :migrate, :create_database

  desc "link dotenv"
  task :link_dotenv do
    on roles(:app, :batch) do
      execute "ln -s /home/deploy/.env #{release_path}/.env"
    end
  end
  before :restart, :link_dotenv

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        if test "[ -f #{fetch(:puma_pid)} ]" and test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
          execute "pumactl -S #{fetch(:puma_state)} restart"
        else
          execute "sudo service puma start"
        end
      end
    end

    on roles(:batch), in: :sequence, wait: 5 do
      within release_path do
        execute "sudo service sidekiq restart"
      end
    end
  end

  after :publishing, :restart
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
