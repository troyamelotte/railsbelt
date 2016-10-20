class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :project
      t.text :desc
      t.integer :ammount_needed
      t.integer :ammount_raised

      t.timestamps null: false
    end
  end
end
