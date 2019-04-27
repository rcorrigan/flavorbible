class Ingredient 
  include Neo4j::ActiveNode
  property :id, type: String

end
