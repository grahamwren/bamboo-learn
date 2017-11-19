class Assignment < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates_uniqueness_of :name, scope: :course, message: '%{value} already exists in this course'
  validates :course, presence: true
end
