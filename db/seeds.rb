# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

users_list = [
    { email: Rails.application.secrets.admin_email,
      user_type: :admin,
      first_name: Rails.application.secrets.admin_first_name,
      last_name: Rails.application.secrets.admin_last_name,
      school_id: '000000',
      password: Rails.application.secrets.admin_password,
      dob: Date.new(1970, 1, 1)
    },
    { email: 'bamboolearntesting+1' + '@' + 'gmail.com',
      user_type: :teacher,
      first_name: 'Teacher',
      last_name: 'Test',
      school_id: '000001',
      password: 'changeM3',
      dob: Date.new(1970, 1, 1)
    },
    { email: 'bamboolearntesting+2' + '@' + 'gmail.com',
      user_type: :student,
      first_name: 'Student',
      last_name: 'Test',
      school_id: '000002',
      password: 'changeM3',
      dob: Date.new(1970, 1, 1)
    }
]

puts "Seeding with env: " + Rails.env
case Rails.env
  when 'development'
    users_list.each do |u|
      User.create(u)
    end
  when 'production'
    # in production force password reset
    users_list.each do |u|
      User.create(u.merge({ password: SecureRandom.hex(64) }))
    end
end