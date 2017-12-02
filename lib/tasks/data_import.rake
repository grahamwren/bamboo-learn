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

end
