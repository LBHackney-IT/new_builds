class CreateSchemePriorities < ActiveRecord::Migration[5.2]
  def change
    create_table :scheme_priorities do |t|
      t.string :name
      t.integer :duration_in_hours
      t.references :scheme, foreign_key: true

      t.timestamps
    end
  end
end
