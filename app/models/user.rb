class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :lockable,
         :rememberable, :trackable, :validatable

  # Users can give lectures
  has_many :lectures, foreign_key: 'instructor_id', class_name: 'Course', dependent: :destroy
  has_many :instructors, through: :lectures
  # Users can take courses
  has_and_belongs_to_many :courses, -> { distinct }, class_name: 'Course'

  enum user_type: [:admin, :teacher, :student]

  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true, length: { minimum: 1 }
  validates :school_id, presence: true # TODO: change this attribute name, it doesnt work with rails naming scheme
  validates :user_type, presence: true
  validates :dob, presence: true

  def name
    self.first_name + ' ' + self.last_name
  end
end
