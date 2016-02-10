class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :payment_amount, precision: 8, scale: 2
      t.date :payment_date
      t.belongs_to :loan, index: true
      t.timestamps null: false
    end
  end
end
