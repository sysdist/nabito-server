require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nabito
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :en
    
    #set available locales
    config.i18n.available_locales = [:en, :sk]
    #config.i18n.available_locales = [:en, :cs, :sk, :pl, :de]
    
    #set local timezone
    #TODO change this!
    config.time_zone = 'Bratislava'
    config.active_record.default_timezone = :local # Or :utc
  end
end
