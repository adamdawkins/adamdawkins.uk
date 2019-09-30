require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module Adamdawkins
  class Application < Rails::Application
    config.load_defaults 5.2
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/micropub', headers: :any, methods: [:get, :post, :options]
      end
    end


    config.generators.system_tests = nil
    config.generators do |g|
      g.test_framework :rspec
      g.javascripts :false
      g.stylesheets :false
      g.assets :false
    end
  end
end
