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

course_list = [
    { short_name: 'CS3200',
      long_name: 'Database Design SEC 1 Fall 2017',
      description: 'This course presents the database design process practiced when creating a ' +
          'relational database; it also presents the relational database management system’s ' +
          'architecture as well as the fundamental ACID properties of a relational database ' +
          'management system. The extended entity- relationship model and normalization will be ' +
          'used in designing relational schemas. Relational algebra and its relationship to the ' +
          'SQL language will be presented. Advanced topics include triggers, stored procedures, ' +
          'indexing, query plan representation, elementary query optimization, and fundamentals ' +
          'of transactions, concurrency and recovery. The course will also include an ' +
          'introduction to NoSQL databases and provide students the opportunity to compare SQL ' +
          'to NoSQL (**time permitting**). Mongo DB functionality and architecture will be ' +
          'reviewed. Students will work in groups to define a database project that includes ' +
          'the design and implementation of a database as well as an application for ' +
          'interacting with the database.'
    }
]

assignment_list = [

]

puts "Seeding with env: " + Rails.env
case Rails.env
  when 'development'
    users_list.each do |u|
      User.create(u)
    end

    course_list.each do |c|
      Course.create(c.merge({ instructor: User.teacher.first}))
    end
  when 'production'
    # in production force password reset
    users_list.each do |u|
      User.create(u.merge({ password: SecureRandom.hex(64) }))
    end
end