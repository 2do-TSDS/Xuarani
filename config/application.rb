require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Xuarani
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Idioma por defecto en español
    config.i18n.default_locale = :es

    # Opcional: asegurar que Rails cargue todos los archivos de locales
    config.i18n.available_locales = [:es, :en]
    config.i18n.fallbacks = [:en]

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    config.autoload_lib(ignore: %w[assets tasks])
  end
end

