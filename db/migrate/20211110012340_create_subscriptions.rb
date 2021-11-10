class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :price
      t.integer :status, default: 0
      t.integer :frequency
      t.integer :ounces
      t.references :customer, foreign_key: true
      t.references :tea, foreign_key: true
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
