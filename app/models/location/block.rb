class Location::Block < Location
  belongs_to :estate, foreign_key: :parent_id
end
