class AddCompletedAtToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :completed_at, :datetime
  end
end
