class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :user

  #has_a grade
  #has_a text
  #has_a created_at

  validates_numericality_of :grade, greater_than: 0, allow_blank: true
  validates :assignment, presence: true
  validates :user, presence: true
  validate  :user_and_assignment_are_somehow_related
  validates :text, length: { maximum: 30000 }

  def user_and_assignment_are_somehow_related
    errors.add(:user, 'User must be in course') unless self.assignment.course.students.exists? self.user.id
  end
end
