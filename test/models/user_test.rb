require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'cannot create user without params' do
    user = User.new
    assert_not user.valid?
  end

  test 'cannot save user with invalid email format' do
    user = User.first
    user.email = 'hello'
    assert_not user.valid?
    user.email = '1234'
    assert_not user.valid?
    user.email = 'google.com'
    assert_not user.valid?
    user.email = 'sam@google.com'
    assert user.valid?
  end
end
