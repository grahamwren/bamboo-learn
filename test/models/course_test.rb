require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course = Course.find_by short_name: 'CS3500'
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
