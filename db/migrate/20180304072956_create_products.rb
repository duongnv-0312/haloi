class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :origin_price
      t.text :description
      t.decimal :special_price

      t.timestamps
    end
  end
end
