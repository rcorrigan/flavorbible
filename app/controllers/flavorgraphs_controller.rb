class FlavorgraphsController < ApplicationController
  def new
    # Default, render new template
  end

  def index
    # Default, render index template to display flavor graphs
  end

  def create
    redirect_to flavorgraphs_path
  end
end
