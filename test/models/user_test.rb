require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @student = users(:student_kelly)
    @teacher = users(:teacher)
  end
  
  test "user can take courses" do
    assert_empty @student.courses
    cs3500 = courses(:cs3500)
    cs3700 = courses(:cs3700)
    @student.courses << cs3500
    assert_equal 1, @student.courses.length
    @student.courses << cs3700
    assert_equal 2, @student.courses.length
  end

  test "user can no take same course twice" do
    @student.courses.clear
    assert_empty @student.courses
    cs3500 = courses(:cs3500)
    @student.courses << cs3500
    assert_equal 1, @student.courses.length
    @student.courses << cs3500
    assert_not_equal 2, @student.courses.length
  end
  
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
