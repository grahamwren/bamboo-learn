class Assignment < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates_uniqueness_of :name, scope: :course, message: '%{value} already exists in this course'
  validates :course, presence: true
  validate :due_date_is_after_current_date

  private

  def due_date_is_after_current_date
    if due_date
      errors.add(:due_date, 'Date must be sometime in the future') unless due_date.future?
    end
  end
end
