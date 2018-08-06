class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :scheme
  belongs_to :scheme_priority
  belongs_to :resident
  belongs_to :location
  has_many :comments
  Statuses = ["Outstanding", "Completed", "EOYD", "Dispute", "Referral", "Rejected"]

  def due_at
    created_at + scheme_priority.duration_in_hours.hours
  end
end
