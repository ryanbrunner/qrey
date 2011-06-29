# set :application, "set your application name here"
# set :repository,  "set your repository location here"
# 
# set :scm, :subversion
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# 
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"
# 
# # if you're still using the script/reaper helper you will need
# # these http://github.com/rails/irs_process_scripts
# 
# # If you are using Passenger mod_rails uncomment this:
# # namespace :deploy do
# #   task :start do ; end
# #   task :stop do ; end
# #   task :restart, :roles => :app, :except => { :no_release => true } do
# #     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
# #   end
# # end

#set :stages, %w(production staging)
#set :default_stage, "production"
require 'bundler/capistrano'

set :application, "qrey"
set :domain,      "yup.la"
#set :repository,  "ssh://#{domain}/~/#{application}.git"
set :repository,  "ssh://#{domain}/~/#{application}.git"
set :use_sudo,    true
set :user, "victorstan"  # The server's user for deploys
set :scm_username, "passenger"
set :scm_passphrase, "p4553ng3rp455"  # The deploy user's password
set :deploy_to,   "/srv/www/#{application}"
set :branch, "victor"
set :deploy_via, :remote_cache
default_run_options[:pty] = true

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
#role :app, 'yuri.yup.la'                          # This may be the same as your `Web` server
#role :db,  'localhost', :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :utils do
  desc "Enable Apache2 site"
  task :enable, :roles => :app do
    sudo "a2ensite #{application}"
    sudo "service apache2 graceful"
  end

  desc "Restart Apache2 Service: sudo service apache2 graceful"
  task :restartA2, :role => :app do
    sudo "service apache2 graceful"
  end
end

namespace :bundler do
  desc "Run: bundle install"
  task :install_gems, :role => :app do
    run "#{current_release} bundle install"
  end

  desc "Run: bundle update"
  task :update_gems, :role => :app do
    run "bundle update"
  end

  desc "Install Bundler"
  task :install_bundler, :role => :app do
    sudo "gem install bundler"
  end
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start, :roles => :app do
#    run "sudo chown -R nobody:www-data /srv/www/#{application}/current/public"
    sudo "chown -R www-data:www-data #{current_release}/public"
    run "touch #{current_release}/tmp/restart.txt"
  end
  task :stop, :roles => :app do
    # Do nothing.
  end
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
#  task :restart, :roles => :app, :except => { :no_release => true } do
#   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  end
end


#after 'utils:restartA2'