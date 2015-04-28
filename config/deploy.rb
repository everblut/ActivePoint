# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'savepoint'
set :repo_url, 'git@github.com:everblut/savepoint.git'
set :user, "rubix"
# Default value for :scm
set :scm, :git

# Default value for :format
set :format, :pretty

# Default value for :log_level
set :log_level, :debug

# Default value for :pty
set :pty, true

# Default value for :linked_files
set :linked_files, fetch(:linked_files, []).push('config/application.yml')

# Default value for linked_dirs
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for keep_releases
set :keep_releases, 3
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to true if using ActiveRecord
set :puma_threads, [1,4]
set :puma_workers, 1

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
  desc "linked dirs"
  task :linked_dirs do
      on release_roles :all do
        execute :mkdir, '-p', linked_dir_parents(release_path)
        fetch(:linked_dirss).each do |dir|
          target = release_path.join(dir)
          source = shared_path.join(dir)
          unless test "[ -L #{target} ]"
            execute :rm, '-rf', target
          end
            execute :ln, '-s', source, target
          end
        end
    end
  desc 'link file application'
  task :linked_files do
      on release_roles :all do
        execute :mkdir, '-p', linked_file_dirs(release_path)
        fetch(:linked_filess).each do |file|
          target = release_path.join(file)
          source = shared_path.join(file)
          unless test "[ -L #{target} ]"
            execute :rm, '-rf', target
          end
          execute :ln, '-s', source, target
        end
      end
  end
  task :precompile do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, "assets:precompile"
        end
      end
    end
  end

  after  :finishing,    :precompile
  after  :finishing,    "deploy:migrate"
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
