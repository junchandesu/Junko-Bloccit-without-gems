 source 'https://rubygems.org'
 
 # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
 gem 'rails', '4.2.4'
 
 group :production do
   gem 'pg'
   gem 'rails_12factor'
 end
 
 group :development do
   gem 'sqlite3'
 end

#The Test database is isolated from the Development and Production databases. 
 group :development, :test do
   gem 'rspec-rails', '~> 3.0'
   # The belong_to and validate_presence_of methods
   gem 'shoulda' 
 end
 
 # Use SCSS for stylesheets
 gem 'sass-rails', '~> 5.0'
 # Use Uglifier as compressor for JavaScript assets
 gem 'uglifier', '>= 1.3.0'
 # Use CoffeeScript for .coffee assets and views
 gem 'coffee-rails', '~> 4.1.0'
 # Use jquery as the JavaScript library
 gem 'jquery-rails'
 # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
 gem 'turbolinks'
 # CSS frameworks
 gem 'bootstrap-sass', '~> 3.3.5'
  # Used for encrypting User passwords
 gem 'bcrypt', '~> 3.1', '>= 3.1.10'
 # hide the sensitive info
 gem 'figaro', '1.0'
 # build objects we can use for testing
 gem 'factory_girl_rails', '~> 4.0'