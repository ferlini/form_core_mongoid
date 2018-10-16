# frozen_string_literal: true

require_relative "boot"

# require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "active_storage/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "form_core"

Dir[Pathname.new(File.dirname(__FILE__)).realpath.parent.join("lib", "monkey_patches", "*.rb")].map do |file|
  require file
end

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Beijing'

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    config.generators do |g|
      g.orm :mongoid
    end
  end
end
