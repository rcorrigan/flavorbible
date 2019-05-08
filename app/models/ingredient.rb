class Ingredient 
  include Neo4j::ActiveNode

  id_property :id
  property :neighbor_count, type: Integer
  property :community, type: Integer

  has_many :both, :relations, rel_class: :RelatedTo

end
