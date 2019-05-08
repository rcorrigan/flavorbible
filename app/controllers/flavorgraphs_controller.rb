class FlavorgraphsController < ApplicationController
  autocomplete :ingredient, :id, limit: 5

  def new
    # Default, render new template
    #@input_ingredient = Ingredient.new(:flavor)
    @popular_ingredients = Ingredient.all
    @popular_ingredients = @popular_ingredients.sort_by { |ent| [Integer(ent.neighbor_count)]}.reverse()[0..9]
  end

  def index
    # Default, render index template to display flavor graphs
    @com = Ingredient.all
    query=Neo4j::ActiveBase.current_session.query("MATCH (n)-[con]-(t) where n.community = '"+String(params[:com])+"' and t.community = '"+String(params[:com])+"' return n,con,t")
    @graphData = {}
    @graphData["nodes"] = []
    @graphData["links"] = []
    @com.each do |i|
      if i["community"] == Integer(params[:com])
        @graphData["nodes"].append({"id":i.id})
      end
    end

    query.rows.each do |ent|
      @graphData["links"].append({"source": ent[0].id, "target":ent[2].id, "value":100/(Integer(ent[1].properties[:weight])+Integer(ent[1].properties[:shared_neighbors])).to_f})
    end
    gon.graphData = @graphData.to_json
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
    @connected_ingredients = @connected_ingredients.sort_by { |ent| [ent[1].weight,ent[1].shared_neighbors,ent[0].neighbor_count,ent[0].community]}
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

  def create_community
    redirect_to '/flavorgraphs/display_community/7'
  end

  def display_community
    @com_number = params[:number]
    @com = {}
  end

end
