class FlavorgraphsController < ApplicationController
  def new
    # Default, render new template
    #@input_ingredient = Ingredient.new(:flavor)
  end

  def index
    # Default, render index template to display flavor graphs
    query_ingredient = Ingredient.find("chicken")
    @connected_ingredients1 = query_ingredient.neighbor1
    @connected_ingredients5 = query_ingredient.neighbor5
    @connected_ingredients20 = query_ingredient.neighbor20
    @connected_ingredients60 = query_ingredient.neighbor60

  end

  def create
    identifier = params[:flavor].to_s
    identifier = identifier.sub("{\"flavor\"=>\"","")
    identifier = identifier.sub("\"}", "")

    if Ingredient.exists?(identifier.downcase)
      ingredient = Ingredient.find(identifier.downcase)
      redirect_to flavorgraph_path(ingredient.id)
    else
      redirect_to new_flavorgraph_path
    end
  end

  def show
    # Render show template - may need to move index actions here to help with id issue
    @query_ingredient = Ingredient.find(params[:id])
    @connected_ingredients1 = @query_ingredient.neighbor1
    @connected_ingredients5 = @query_ingredient.neighbor5
    @connected_ingredients20 = @query_ingredient.neighbor20
    @connected_ingredients60 = @query_ingredient.neighbor60
  end

end
