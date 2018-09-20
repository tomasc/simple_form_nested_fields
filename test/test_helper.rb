$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simple_form_nested_fields'

require 'bundler/setup'
require 'mongoid'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

require 'rails/test_help'

require 'minitest/around'
require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest/spec'
require 'minitest/spec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActionView::TestCase
  include SimpleForm::ActionViewExtensions::FormHelper
end
