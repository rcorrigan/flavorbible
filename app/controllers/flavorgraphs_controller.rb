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
    ingredient = Ingredient.find(params[:id])
    redirect_to flavorgraph_path(ingredient.id)
  end

  def show
    # Render show template - may need to move index actions here to help with id issue
    query_ingredient = Ingredient.find(params[:id])
    @connected_ingredients1 = query_ingredient.neighbor1
    @connected_ingredients5 = query_ingredient.neighbor5
    @connected_ingredients20 = query_ingredient.neighbor20
    @connected_ingredients60 = query_ingredient.neighbor60
  end

end
