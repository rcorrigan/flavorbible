class ComsController < ApplicationController

  def new
    identifier = params[:number]
    identifier = identifier.sub("{\"number\"=>\"","")
    identifier = identifier.sub("\"}", "")

    redirect_to coms_path(identifier)
  end

  def create
    redirect_to coms_path
  end

  def show

  end

  def index
    # Index
  end
end