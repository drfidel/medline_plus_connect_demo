source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '~> 5.0'

gem 'aldous' # Build DRY service objects.  
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
gem 'bootstrap', '~> 4.0.0.alpha4'
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails'
gem 'pg' # PostgreSQL
gem 'puma', '~> 3.0'
# gem 'redis', '~> 3.0' # Use Redis adapter to run Action Cable in production
source 'https://rails-assets.org' do # 'tether' required for bootstrap tooltips (or non-custom bootstrap import)
  gem 'rails-assets-tether', '>= 1.1.0'
end
gem 'rest-client'
gem 'sass-rails', '~> 5.0'
gem 'therubyracer' # needed as a JS runtime
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

group :development, :test do
  gem 'byebug', platform: :mri # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'spring'  # Spring speeds up development by keeping running app in the background.
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', require: false
  gem 'test-unit'
end