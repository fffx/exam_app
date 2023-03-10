# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "exam_app"
set :repo_url, "git@github.com:fffx/exam_app.git"
set :branch, "main"
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :bundle_jobs, 1
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/exam_app"
set :puma_enable_socket_service, true
set :puma_phased_restart, true

set :puma_threads, [4, 16]
# set :puma_workers,    0

set :keep_assets, 2
set :migration_role, :app

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
# append :linked_files, 'config/database.yml', 'config/secrets.yml'
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


append :linked_files, "config/master.key"

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end

  desc "reload the database with seed data"
  task :seed do
    on roles(:db) do
      within current_path do
        execute :bundle, "exec rake db:seed RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end
end


