require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ConsumersCabinet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ru
    puts "---> Consumer Cabinet is started! <--- "

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      class_attr_index = html_tag.index 'class="'

      if class_attr_index
        html_tag.insert class_attr_index + 7, 'is-invalid '
      else
        html_tag.insert html_tag.index('>'), ' class="is-invalid"'
      end   
    }

    # Remove ActiveStorage routes
    initializer(:remove_activestorage_routes, after: :add_routing_paths) {|app|
      app.routes_reloader.paths.delete_if {|path| path =~ /activestorage/}
    }
  end
end
