class Issue < ApplicationRecord
  belongs_to :user
  belongs_to :scheme
  belongs_to :scheme_priority
  belongs_to :resident
  belongs_to :location
  has_many :comments
  Statuses = ["Outstanding", "Completed", "EOYD", "Dispute", "Referral", "Rejected"]
  before_save :set_due_at

  scope :overdue, -> { where("due_at < ?", Time.now) }
  scope :open, -> { where("status = 'Outstanding'") }

  def set_due_at
    created_at = self.created_at || Time.now
    self.due_at = created_at + self.scheme_priority.duration_in_hours.hours
  end

  def overdue?
    self.due_at < Time.now && status == 'Outstanding'
  end
end
