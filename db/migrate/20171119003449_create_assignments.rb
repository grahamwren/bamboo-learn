class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.string      :name,        limit: 256,         null: false
      t.string      :description, limit: 5000,        default: ''
      t.integer     :points,      default: 0
      t.references  :course,      foreign_key: true,  index: true,  null: false

      t.timestamps
    end
  end
end
