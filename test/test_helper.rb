require 'warden'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include Warden::Test::Helpers

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

end