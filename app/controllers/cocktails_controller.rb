class CocktailsController < ApplicationController
  def index
    if params[:query]
      @query = params[:query]
      @cocktails = Cocktail.where("name ILIKE '%#{params[:query]}%'")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.all.find(params[:id])
    @dose = Dose.where(cocktail_id: params[:id])
  end

  def new
  end

  def create
  end
end
