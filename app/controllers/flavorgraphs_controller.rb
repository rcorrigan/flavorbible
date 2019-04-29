class FlavorgraphsController < ApplicationController
  def new
    # Default, render new template
  end

  def index
    # Default, render index template to display flavor graphs
    query_ingredient = Ingredient.find("chicken")
    @connected_ingredients = query_ingredient.neighbor20
  end

  def create
    redirect_to flavorgraphs_path
  end
end
