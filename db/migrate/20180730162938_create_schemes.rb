class CreateSchemes < ActiveRecord::Migration[5.2]
  def change
    create_table :schemes do |t|
      t.string :name

      t.timestamps
    end
  end
end
