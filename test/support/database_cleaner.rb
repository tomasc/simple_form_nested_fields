require 'database_cleaner'

DatabaseCleaner.orm = :mongoid
DatabaseCleaner.strategy = :truncation

class MiniTest::Spec
  before(:each) { DatabaseCleaner.clean }
end

class Capybara::Rails::TestCase
  before(:each) { DatabaseCleaner.clean }
end
