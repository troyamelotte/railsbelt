class CreateLendings < ActiveRecord::Migration
  def change
    create_table :lendings do |t|
      t.references :lender, index: true
      t.references :borrower, index: true
      t.integer :ammount

      t.timestamps null: false
    end
    add_foreign_key :lendings, :lenders
    add_foreign_key :lendings, :borrowers
  end
end
