require 'rails_helper'

RSpec.describe Issue, type: :model do
  it "calculates the due date from the scheme priority" do
    scheme = create(:scheme)
    scheme_priority = create(:scheme_priority, scheme: scheme, duration_in_hours: 36)
    issue = create(:issue, scheme: scheme, scheme_priority: scheme_priority, created_at: "01/01/2018 12:00".to_time)
    expect(issue.due_at).to eq("03/01/2018 00:00")
  end

  it "updates the due date on update" do
    scheme = create(:scheme)
    scheme_priority1 = create(:scheme_priority, scheme: scheme, duration_in_hours: 36)
    scheme_priority2 = create(:scheme_priority, scheme: scheme, duration_in_hours: 48)
    issue = create(:issue, scheme: scheme, scheme_priority: scheme_priority1, created_at: "01/01/2018 12:00".to_time)
    expect(issue.due_at).to eq("03/01/2018 00:00")
    issue.scheme_priority = scheme_priority2
    issue.save!
    expect(issue.due_at).to eq("03/01/2018 12:00")
  end
end
