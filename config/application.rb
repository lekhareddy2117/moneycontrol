require_relative 'boot'

require 'rails/all'
require 'rack/throttle'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Moneycontrol
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.middleware.use Rack::Attack
    # rules = [{ method: "GET", path: "/api/v1/companies", limit: 3 } ]
    # config.middleware.use Rack::Throttle::Rules, rules: rules, time_window: :minute, :cache => Redis.new, :key_prefix => :throttle
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
