class Resident < ApplicationRecord
  belongs_to :dwelling, class_name: 'Location::Dwelling'
end
