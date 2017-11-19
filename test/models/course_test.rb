require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course = courses(:cs3500)
  end

  test "course can have students" do
    assert_empty @course.students
    kelly = users(:student_kelly)
    alex = users(:student_alex)
    @course.students << kelly
    assert_equal 1, @course.students.length
    @course.students << alex
    assert_equal 2, @course.students.length
  end

  test "course cannot have same student twice" do
    @course.students.clear
    assert_empty @course.students
    kelly = users(:student_kelly)
    @course.students << kelly
    assert_equal 1, @course.students.length
    @course.students << kelly
    assert_not_equal 2, @course.students.length
  end

  test "only a teacher can teach a course" do
    @course.instructor = users(:student_alex)
    assert_not @course.valid?
    assert_not_empty @course.errors[:instructor]
  end

  test "valid course" do
    assert @course.valid?
    assert_empty @course.errors.values
  end

  test "valid course without long name" do
    @course.long_name = ''
    assert @course.valid?
    assert_empty @course.errors[:long_name]
  end

  test "valid course without description" do
    @course.description = ''
    assert @course.valid?
    assert_empty @course.errors[:description]
  end

  test "invalid course without short name" do
    @course.short_name = ''
    assert_not @course.valid?
    assert_not_empty @course.errors[:short_name]
  end

  test "invalid course with short name too long" do
    @course.short_name = 'this is a way too long string'
    assert_not @course.valid?
    assert_not_empty @course.errors[:short_name]
  end

  test "invalid course without instructor" do
    @course.instructor = nil
    assert_not @course.valid?
    assert_not_empty @course.errors[:instructor]
  end
end
