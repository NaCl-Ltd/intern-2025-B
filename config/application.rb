require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    config.active_storage.variant_processor = :mini_magick
    config.i18n.available_locales = [:en, :ja]
  end
end
