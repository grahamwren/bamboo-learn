class AddTypeNameSchoolDobToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_type, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :school_id, :string
    add_column :users, :dob, :date

    add_index :users, :school_id, unique: true
  end
end
