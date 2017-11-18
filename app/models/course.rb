class Course < ApplicationRecord
  # A Course has a single instructor
  belongs_to :instructor, class_name: 'User'
  # A Course has many students, and students can take multiple courses
  has_and_belongs_to_many :students, class_name: 'User'

  validates :short_name, presence: true, length: { maximum: 10 }
  validates_uniqueness_of :short_name
  validates :long_name, length: { maximum: 255 }
  validates :description, length: { maximum: 5000 }
  validates :instructor, presence: true
end
