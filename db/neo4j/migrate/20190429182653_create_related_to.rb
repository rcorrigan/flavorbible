class CreateRelatedTo < Neo4j::Migrations::Base
  def up
    add_constraint :RelatedTo, :uuid
  end

  def down
    drop_constraint :RelatedTo, :uuid
  end
end
