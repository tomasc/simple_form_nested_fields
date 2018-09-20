lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_form_nested_fields/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_form_nested_fields'
  spec.version       = SimpleFormNestedFields::VERSION
  spec.authors       = ['Tomas Celizna', 'Asger Behncke Jacobsen']
  spec.email         = ['tomas.celizna@gmail.com', 'a@asgerbehnckejacobsen.dk']

  spec.summary       = 'Dynamically create and remove nested fields with simple_form'
  spec.homepage      = 'https://github.com/tomasc/simple_form_nested_fields'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'simple_form'
  spec.add_dependency 'mongoid'
  spec.add_dependency 'coffee-rails'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'rails-assets-sortablejs'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'capybara-screenshot'
  spec.add_development_dependency 'capybara', '~> 2.1'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'minitest-around'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'minitest-metadata'
  spec.add_development_dependency 'minitest-rails-capybara'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'selenium-webdriver'
end
