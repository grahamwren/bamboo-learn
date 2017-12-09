class Course < ApplicationRecord
  # A Course has a single instructor
  belongs_to :instructor, class_name: 'User'
  # A Course has many students, and students can take multiple courses
  has_and_belongs_to_many :students, -> { distinct }, class_name: 'User'
  has_many :assignments, dependent: :destroy

  validates :short_name, presence: true, length: { maximum: 10 }
  validates_uniqueness_of :short_name
  validates :long_name, length: { maximum: 255 }
  validates :description, length: { maximum: 5000 }
  validates :instructor, presence: true
  validate :validate_instructor_is_teacher

  def grade(user)
    grade = { n: 0, d: 0 }
    assignments.to_a.inject(grade) do |running_grade, a|
      next running_grade unless a.top_score(user)
      running_grade[:n] += a.top_score(user)
      running_grade[:d] += a.points || 0
      running_grade
    end
    grade[:d] && grade[:d] != 0 ? (grade[:n] * 1.0) / (grade[:d] * 1.0) * 100 : nil
  end

  private

  def validate_instructor_is_teacher
    errors.add(:instructor, "in not a teacher") unless instructor && instructor.teacher?
  end
end
