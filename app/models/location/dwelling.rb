class Location::Dwelling < Location
  belongs_to :scheme
  has_many :residents
end
