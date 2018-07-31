class Scheme < ApplicationRecord
  has_many :issues
  has_many :dwellings, class_name: 'Location::Dwelling'
  has_many :scheme_priorities

  def locations
    dwellings.collect {|x| x.self_and_ancestors}.flatten.uniq.sort_by {|x| [x.depth, x.id]}
  end

  def residents
    dwellings.collect {|x| x.residents}.flatten
  end
end
