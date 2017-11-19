class Assignment < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :course, presence: true
end
