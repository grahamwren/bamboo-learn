require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  setup do
    @assignment = assignments(:homework_1)
  end

  test "valid assignment" do
    assert @assignment.valid?
    assert_empty @assignment.errors.values
  end

  test "valid assignment without description" do
    @assignment.description = ''
    assert @assignment.valid?
    assert_empty @assignment.errors[:description]
  end

  test "invalid assignment if name taken" do
    assignment_w_name_conflict = Assignment.new name: 'Homework 1',
                                                course: courses(:cs3700)
    assert assignment_w_name_conflict.valid?
    assignment_w_name_conflict.course = courses(:cs3500)
    assert_not assignment_w_name_conflict.valid?
    assert_not_empty assignment_w_name_conflict.errors[:name]
  end

  test "invalid assignment without name" do
    @assignment.name = ''
    assert_not @assignment.valid?
    assert_not_empty @assignment.errors[:name]
    @assignment.errors[:name].clear
  end

  test "invalid assignment with name too long" do
    100.times { @assignment.name += 'hello' }
    assert_not @assignment.valid?
    assert_not_empty @assignment.errors[:name]
    @assignment.errors[:name].clear
  end

  test "invalid assignment without course" do
    @assignment.course = nil
    assert_not @assignment.valid?
    assert_not_empty @assignment.errors[:course]
  end
end
