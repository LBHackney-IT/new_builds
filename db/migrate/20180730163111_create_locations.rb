class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :parent_id
      t.references :scheme, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
