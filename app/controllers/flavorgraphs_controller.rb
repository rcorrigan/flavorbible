class FlavorgraphsController < ApplicationController
  def new
    # Default, render new template
  end

  def index
    # Default, render index template to display flavor graphs
    query_ingredient = Ingredient.find("monkfish")
    @connected_ingredients1 = query_ingredient.neighbor1
    @connected_ingredients5 = query_ingredient.neighbor5
    @connected_ingredients20 = query_ingredient.neighbor20
    @connected_ingredients60 = query_ingredient.neighbor60

  end

  def create
    redirect_to flavorgraphs_path
  end
end
