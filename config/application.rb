require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module DICManyoExam
  class Application < Rails::Application
    config.load_defaults 5.2
    # config.time_zone = 'Tokyo'
    # config.active_record.default_timezone = :local
    # config.i18n.default_locale = :ja
    config.generators do |g|
      g.test_framework :rspec,
                       model_specs: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
