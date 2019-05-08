class Ingredient 
  include Neo4j::ActiveNode

  id_property :id
  property :neighbor_count
  property :community

  has_many :both, :relations, rel_class: :RelatedTo

end
