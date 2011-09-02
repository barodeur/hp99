source 'http://rubygems.org'

# gem 'rails', '3.1.0.rc6'

# Bundle edge Rails instead:
gem 'rails', '~> 3.1.0'

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

# Mongoid
gem "mongoid", "~> 2.2"
gem 'bson_ext'
gem "devise", "~> 1.4.4"
gem 'nokogiri', :require => 'nokogiri'
gem 'haml-rails'
gem 'airbrake'

group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

group :development do
  gem 'pry'
end

group :test do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'pry'
  gem 'rspec-rails'
end

group :staging do
  gem 'unicorn'
end

group :production do
  gem 'unicorn'
end
