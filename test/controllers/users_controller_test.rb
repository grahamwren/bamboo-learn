require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
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

  test "admin can create user" do
    login_as @admin, scope: :user
    post users_url, params: { user: @user_params }
    assert_response :success
    assert_template :index
    assert User.exists? school_id: 666
    User.find_by(school_id: 666).destroy
  end

  test "teacher cannot create user" do
    login_as @teacher, scope: :user
    post users_url, params: { user: @user_params }
    assert_response :unauthorized
    assert_not User.exists? school_id: 666
  end

  test "student cannot create user" do
    login_as @student, scope: :user
    post users_url, params: { user: @user_params }
    assert_response :unauthorized
    assert_not User.exists? school_id: 666
  end

  test "admin can edit any user" do
    # Edit other user
    login_as @admin, scope: :user
    new_user = User.create @user_params
    patch user_url(new_user), params: { user: { first_name: 'jamie' } }
    assert_response :success
    assert_template :edit
    assert_equal 'jamie', User.find(new_user.id).first_name
    new_user.destroy

    # Edit self
    init = @admin.dob
    patch user_url(@admin), params: { user: { dob: @admin.dob + 1.year } }
    assert_response :success
    assert_template :edit
    assert_equal init + 1.year, User.find(@admin.id).dob
    @admin.dob = init
  end

  test "teacher can only edit themselves" do
    # Fail to edit other user
    login_as @teacher, scope: :user
    new_user = User.create @user_params
    patch user_url(new_user), params: { user: { first_name: 'jamie' } }
    assert_response :unauthorized
    assert_not_equal 'jamie', User.find(new_user.id).first_name
    new_user.destroy

    # Edit self
    init = @teacher.dob
    patch user_url(@teacher), params: { user: { dob: @teacher.dob + 1.year } }
    assert_response :success
    assert_template :edit
    assert_equal init + 1.year, User.find(@teacher.id).dob
    @teacher.dob = init
  end


  test "student can only edit themselves" do
    # Fail to edit other user
    login_as @student, scope: :user
    new_user = User.create @user_params
    patch user_url(new_user), params: { user: { first_name: 'jamie' } }
    assert_response :unauthorized
    assert_not_equal 'jamie', User.find(new_user.id).first_name
    new_user.destroy

    # Edit self
    init = @student.dob
    patch user_url(@student), params: { user: { dob: @student.dob + 1.year } }
    assert_response :success
    assert_template :edit
    assert_equal init + 1.year, User.find(@student.id).dob
    @teacher.dob = init
  end

  test "admin can delete user" do
    login_as @admin, scope: :user
    new_user = users(:student_kelly).dup
    new_user.email = 'newemail@bamboo.com'
    new_user.password = 'password'
    new_user.school_id = 666
    new_user.save!
    delete user_url new_user
    assert_response :success
    assert_template :index
    assert_not User.exists?(new_user.id)
  end

  test "teacher cannot delete user" do
    user = users :student_kelly
    login_as @teacher, scope: :user
    delete user_url user
    assert_response :unauthorized
    assert User.exists?(user.id)
  end

  test "student cannot delete user" do
    user = users :student_kelly
    login_as @student, scope: :user
    delete user_url user
    assert_response :unauthorized
    assert User.exists?(user.id)
  end
end