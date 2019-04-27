class Ingredient 
  include Neo4j::ActiveNode

  id_property :id
  has_many :both, :neighbor20, type: :"20", model_class: [:Ingredient]
  has_many :both, :neighbor1, type: :"1", model_class: [:Ingredient]
  has_many :both, :neighbor5, type: :"5", model_class: [:Ingredient]
  has_many :both, :neighbor60, type: :"60", model_class: [:Ingredient]
end
