set :application, 'carhall'
set :repo_url, 'git@github.com:bbtfr/carhall.git'
set :branch, 'deploy'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/carhall'
# set :scm, :git

set :format, :pretty
set :log_level, :info
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/javascripts}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Change owner www-data'
  task :chown do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      execute :chown, '-R www-data', release_path
      execute :chgrp, '-R www-data', release_path
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

end

namespace :logs do
  desc "tail rails logs" 
  task :tail_rails do
    invoke "logs:tail", fetch(:rails_env)
  end
  
  task :tail, :file do |t, args|
    if args[:file]
      on roles(:app) do
        trap("INT") { exit }
        SSHKit.config.output_verbosity = :debug
        execute "tail -f #{shared_path}/log/#{args[:file]}.log"
      end
    else
      puts "please specify a logfile e.g: 'rake logs:tail[logfile]"
      puts "will tail 'shared_path/log/logfile.log'"
      puts "remember if you use zsh you'll need to format it as:"
      puts "rake 'logs:tail[logfile]' (single quotes)"
    end
  end
end