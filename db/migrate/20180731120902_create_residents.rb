class CreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :dwelling_id

      t.timestamps
    end
  end
end
