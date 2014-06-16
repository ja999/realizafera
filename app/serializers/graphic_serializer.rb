class GraphicSerializer < ActiveModel::Serializer
  attributes :date

  has_many :productions
end
