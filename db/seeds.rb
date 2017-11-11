# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'

users_list = [
    { email: 'bamboolearntesting' + '@' + 'gmail.com', user_type: :admin, first_name: 'admin', last_name: 'bamboo', school_id: '000000', password: 'changeM3', dob: Date.new(1970, 1, 1) },
    { email: 'bamboolearntesting+1' + '@' + 'gmail.com', user_type: :student, first_name: 'Graham', last_name: 'Wren', school_id: '000001', password: 'changeM3', dob: Date.new(1970, 1, 1) },
    { email: 'bamboolearntesting+2' + '@' + 'gmail.com', user_type: :teacher, first_name: 'Yasmine', last_name: 'Ghannam', school_id: '000002', password: 'changeM3', dob: Date.new(1970, 1, 1) }
]


# users_list.each do |u|
#   User.create(u)
# end

puts "Seeding with env: " + Rails.env
case Rails.env
  when 'development'
    users_list.each do |u|
      User.create(u)
    end
  when 'production'
    # in production force password reset for admin user
    users_list.each do |u|
      User.create(u.merge({ password: SecureRandom.hex(64) }))
    end
end