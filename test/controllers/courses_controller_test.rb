require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Warden.test_mode!
    @admin = users :admin
    @teacher = users :teacher
    @student = users :student_alex
    @user_params = {
        school_id: 666, user_type: 'student',
        email: 'jessie@bamboo.com', first_name: 'jessie',
        last_name: 'test', dob: Date.new(1970,1,1),
        password: 'this is a terrible password'
    }
  end

  teardown do
    Warden.test_reset!
  end

  test 'Admin able to index all courses' do
    login_as @admin, scope: :user
    get courses_url
    assert_response :success
    assert_template :index
  end

  test 'Teacher able to index all courses' do
    login_as @teacher, scope: :user
    get courses_url
    assert_response :success
    assert_template :index
  end

  test 'Student able to index all courses' do
    login_as @student, scope: :user
    get courses_url
    assert_response :success
    assert_template :index
  end
end
