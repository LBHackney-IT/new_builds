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

  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
              :available_filters => %w[
                sorted_by
                search_query
                overdue_filter
                location
                status_filter
                reported_by
                priority_filter
                trade_filter
              ]

  scope :overdue_filter, lambda { |flag|
    return nil if 0 == flag # checkbox unchecked
    where("due_at < ?", Time.now).where("status = 'Outstanding'")
  }

  scope :status_filter, lambda { |status|
    return nil if status.blank?
    where("status = ?", status)
  }

  scope :priority_filter, lambda { |priority|
    return nil if priority.blank?
    where("scheme_priority_id = ?", priority)
  }

  scope :trade_filter, lambda { |trade|
    return nil if trade.blank?
    where("trade = ?", trade)
  }

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 3
    where(
      terms.map {
        or_clauses = [
          "LOWER(urn) LIKE ?",
          "LOWER(description) LIKE ?",
          "LOWER(trade) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :location, lambda { |location_id|
    where(location_id: location_id)
  }

  scope :reported_by, lambda { |user_id|
    where(user_id: user_id)
  }

  def self.options_for_sorted_by
    [
      ['Created at (newest first)', 'created_at_desc'],
      ['Created at (oldest first)', 'created_at_asc'],
    ]
  end


  def set_due_at
    created_at = self.created_at || Time.now
    self.due_at = created_at + self.scheme_priority.duration_in_hours.hours
  end

  def overdue?
    self.due_at < Time.now && status == 'Outstanding'
  end

  def overdue_or_status
    overdue? ? 'overdue' : status.downcase
  end
end
