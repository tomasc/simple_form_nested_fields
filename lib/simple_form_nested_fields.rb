require 'simple_form'

# TODO: Remove these somehow
require 'rails'
require 'rails-assets-sortablejs'

require 'simple_form_nested_fields/version'

require 'simple_form_nested_fields/action_view_extension'
require 'simple_form_nested_fields/nested_fields_builder'
require 'simple_form_nested_fields/railtie' if defined?(Rails)

I18n.load_path += Dir.glob(File.join( File.dirname(__FILE__), 'config', 'locales', '*.yml' ))

module SimpleFormNestedFields
  def self.asset_path
    File.expand_path('../assets/javascripts', __FILE__)
  end
end
