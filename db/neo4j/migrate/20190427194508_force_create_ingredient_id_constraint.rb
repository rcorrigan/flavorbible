class ForceCreateIngredientIdConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Ingredient, :id, force: true
  end

  def down
    drop_constraint :Ingredient, :id
  end
end
