class CreateCoupon < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :status, default: 0
      t.string :code
      t.float :amount #% or $$  off eg 50.0
      t.string :type #% or $ off  eg 50% or $50
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
