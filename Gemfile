source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'rqrcode'
gem 'rmagick'

# Asset template engines
gem 'sass'
gem 'compass'
gem 'haml', '3.1.2'
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'
# gem 'therubyracer'
gem 'inherited_resources'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

# for herku's sake!
group :development, :test do
  gem 'therubyracer'
  gem 'sqlite3'
  gem 'capistrano'
end

group :production do
  gem 'therubyracer-heroku'
  gem 'pg'
end
