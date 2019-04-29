class FlavorgraphsController < ApplicationController
  def new
    # Default, render new template
    #@input_ingredient = Ingredient.new(:flavor)
  end

  def index
    # Default, render index template to display flavor graphs
    query_ingredient = Ingredient.find("chicken")
    @connected_ingredients = query_ingredient.neighbor

  end

  def create
    identifier = params[:flavor].to_s
    identifier = identifier.sub("{\"flavor\"=>\"","")
    identifier = identifier.sub("\"}", "")

    if Ingredient.exists?(identifier.downcase)
      ingredient = Ingredient.find(identifier.downcase)
      redirect_to flavorgraph_path(ingredient.id)
    else
      flash[:notice] = "Ingredient: \"" + identifier.downcase + "\" not found."
          redirect_to new_flavorgraph_path

    end
  end

  def show
    # Render show template - may need to move index actions here to help with id issue
    @query_ingredient = Ingredient.find(params[:id])
    @connected_ingredients = @query_ingredient.relations.zip(@query_ingredient.relations.rels)
    @connected_ingredients = @connected_ingredients.sort_by { |ent| [ent[1].weight,ent[1].shared_neighbors]}
    @connected_ingredients = @connected_ingredients.reverse

  end

end
