namespace :data_import do
  desc 'Rake tasks responsible for building prod course data'
  task build_assignments: :environment do
    Course.all.each do |c|
      (1...10).each do |i|
        a = {
            name: "Homework #{i}",
            description: "This is the #{i.ordinalize} homework assignment for #{c.short_name}.",
            due_date: DateTime.now + 1.month,
            points: 100,
            course: c
        }
        Assignment.find_or_create_by a
      end
    end
  end

  task build_users: :environment do
    input = ''
    STDOUT.puts 'Please enter a password for student, teacher, and admin accounts'
    input = STDIN.gets.chomp
    ['student', 'teacher', 'admin'].each_with_index do |type, i|
      next if User.where(email: type + '@bamboo.com').any?
      User.create({
        email: type + '@bamboo.com',
        password: input,
        user_type: type,
        first_name: 'Bamboo',
        last_name: type.capitalize,
        dob: 20.years.ago,
        school_id: i,
      })
      end
  end
end
