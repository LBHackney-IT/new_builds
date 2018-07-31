class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :urn
      t.references :user, foreign_key: true
      t.references :scheme, foreign_key: true
      t.references :scheme_priority, foreign_key: true
      t.references :resident, foreign_key: true
      t.references :location, foreign_key: true
      t.text :description
      t.string :trade
      t.string :status

      t.timestamps
    end
  end
end
