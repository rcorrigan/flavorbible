class FlavorgraphsController < ApplicationController
  autocomplete :ingredient, :id, limit: 5

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

    @graphData={}
    @graphData["nodes"]=[{"id":@query_ingredient.id}]
    @graphData["links"]=[]
    @connected_ingredients.each do |i|
      @graphData["links"].append({"source":@query_ingredient.id,"target":i[0].id,"value":100/(i[1].weight+i[1].shared_neighbors).to_f})
      @graphData["nodes"].append({"id":i[0].id})
    end
    gon.graphData = @graphData.to_json
  end
end
