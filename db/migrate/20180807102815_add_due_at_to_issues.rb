class AddDueAtToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :due_at, :datetime
  end
end
