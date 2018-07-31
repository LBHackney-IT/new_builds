class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :scheme
  belongs_to :scheme_priority
  belongs_to :resident
  belongs_to :location
  Statuses = ["Outstanding", "Completed", "EOYD", "Dispute", "Referral", "Rejected"]
end
