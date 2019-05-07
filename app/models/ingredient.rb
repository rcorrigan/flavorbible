class Ingredient 
  include Neo4j::ActiveNode

  id_property :id
  property :count
  has_many :both, :relations, rel_class: :RelatedTo

end
