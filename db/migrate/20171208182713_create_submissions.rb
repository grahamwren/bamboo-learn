class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.integer :grade, default: nil
      t.text :text, limit: 30000
      t.belongs_to :user, index: true
      t.belongs_to :assignment, index: true

      t.timestamps
    end
  end
end
