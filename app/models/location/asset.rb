class Location::Asset < Location
  belongs_to :block, foreign_key: :parent_id
end
