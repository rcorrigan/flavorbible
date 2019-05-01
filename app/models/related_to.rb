class RelatedTo 
  include Neo4j::ActiveRel
  from_class :Ingredient
  to_class :Ingredient
  type 'RELATED'
  property :weight, type: Integer
  property :shared_neighbors, type: Integer


end
