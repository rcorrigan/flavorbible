MATCH (n:Ingredient) WITH collect(n.id) as ings // lists ingredients, collects them into a list
UNWIND ings AS ing // this is the foreach thing
MATCH (source)-[con]-(target)
  WHERE source.id=ing // match all edges connected to each node
WITH source, con, target // pass these to the scope of the next match
MATCH (source)—-(neighbor)-—(target) // find all shared neighbors with their neighbors
WITH source,target,con,count(neighbor) as num // pass these to scope of last part of query
SET con.shared_neighbors=num // set the shared_neighbors property on each of the aforementioned edges
RETURN source.id as source,target.id as target, con // this part could maybe be safely excluded