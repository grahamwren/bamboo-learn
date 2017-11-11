class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :lockable,
         :rememberable, :trackable, :validatable


  enum user_type: [:admin, :teacher, :student]

  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true, length: { minimum: 1 }
  validates :school_id, presence: true # TODO: change this attribute name, it doesnt work with rails naming scheme
  validates :user_type, presence: true
  validates :dob, presence: true
end
