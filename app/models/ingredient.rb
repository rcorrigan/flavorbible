class Ingredient 
  include Neo4j::ActiveNode

  id_property :id
  has_many :both, :neighbor, type: :"RELATED", model_class: [:Ingredient]
end
