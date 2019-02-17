source 'https://rubygems.org'

ruby '2.5.1'

gem 'rails', '~> 5.2.2'

# Infrastructure
gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 3.11'
gem 'sidekiq'

# Metrics
gem 'barnes'

# Database
gem 'data_migrate'
gem 'pg', '>= 0.18', '< 2.0'

# Language
gem 'andand', git: 'https://github.com/raganwald/andand'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails'

# Functionality
gem 'friendly_id', '~> 5.2.4'
gem 'webmention-verification'

## Html Pipeline & Dependencies
gem 'html-pipeline'

gem 'commonmarker', '~> 0.16' # Markdown Filter
gem 'html-pipeline-hashtag'   # Hashtag Filter
gem 'rinku', '~> 1.7'         # Autolink Filter

## HTTP Client
gem 'httparty'

## Parsing
gem 'nokogiri'
gem 'microformats'
gem 'nitlink', '~> 1.1'

## Third Party APIs
gem 'twitter'

# UI
gem 'simple_form'
gem 'turbolinks', '~> 5.2.0'


group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rails_config'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'vcr'
  gem 'webmock'
end
