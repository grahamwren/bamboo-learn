class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string      :short_name,  limit: 256,   null: false
      t.string      :long_name,   limit: 256,   default: ''
      t.string      :description, limit: 5000,  default: ''
      t.references  :instructor,  index: true,  null: false

      t.timestamps
    end

    create_table :courses_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
    end
  end
end
