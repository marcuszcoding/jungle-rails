class CreateProductSpecs < ActiveRecord::Migration[6.1]
  def change
    create_table :product_specs do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :quantity
      t.string :category

      t.timestamps
    end
  end
end
